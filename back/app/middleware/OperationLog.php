<?php

namespace app\middleware;

use app\helper\OperationLogHelper;
use app\Request;
use Closure;
use JsonException;
use think\facade\Log;
use think\Response;
use think\response\File;
use Throwable;

class OperationLog
{
    /**
     * 记录请求内容、处理结果和耗时
     * @param Request $request
     * @param Closure $next
     * @param int $terminal
     * @return Response
     */
    public function handle(Request $request, Closure $next, int $terminal): Response
    {
        try {
            $data = [
                'terminal' => $terminal,
                'api' => $request->baseUrl(),
                'request_method' => $request->method(true),
                'request_content' => $this->getRequestContent($request),
                'ip' => $request->ip(),
                'time' => time()
            ];

            $startTime = hrtime(true);
        } catch (Throwable $exception) {
            $this->log('采集请求内容失败：' . $exception->getMessage());
            return $next($request);
        }

        $response = $next($request); //ThinkPHP会将控制器异常交给ExceptionHandle转换成响应

        try {
            $data['duration'] = round((hrtime(true) - $startTime) / 1000000);
            $responseData = $response->getData(); //响应元素数据
            $responseHttpCode = $response->getCode(); //响应状态码

            $data['session_id'] = $request->sessionId;
            $data['department_id'] = $request->departmentId;
            $data['user_id'] = $request->userId;
            $data['response_http_code'] = $responseHttpCode;
            $data['response_business_code'] = $this->getBusinessCode($responseHttpCode, $responseData);
            $data['response_content'] = $this->getResponseContent($response);

            $operationLogHelper = new OperationLogHelper();
            $operationLogHelper->add($data);
        } catch (Throwable $exception) {
            $this->log('写入操作日志失败：' . $exception->getMessage());
        }

        return $response;
    }

    /**
     * 获取请求header、文件信息和请求参数
     * @param Request $request
     * @return string
     * @throws JsonException
     */
    public function getRequestContent(Request $request): string
    {
        return json_encode([
            'header' => $request->header(),
            'files' => $this->getRequestFiles($request->file() ?? []),
            'body' => $request->param(false)
        ], JSON_UNESCAPED_UNICODE | JSON_THROW_ON_ERROR);
    }

    /**
     * 获取上传文件的文件名、大小、临时路径和类型
     * @param array $files
     * @return array
     */
    private function getRequestFiles(array $files): array
    {
        $requestFiles = [];
        foreach ($files as $key => $file) {
            if (is_array($file)) {
                $requestFiles[$key] = $this->getRequestFiles($file);
            } else {
                $requestFiles[$key] = [
                    'name' => $file->getOriginalName(),
                    'size' => $file->getSize(),
                    'path' => $file->getPathname(),
                    'type' => $file->getOriginalMime(),
                    'ext' => $file->getOriginalExtension(),
                ];
            }
        }

        return $requestFiles;
    }

    /**
     * 获取响应内容
     * @param Response $response
     * @return string
     */
    private function getResponseContent(Response $response): string
    {
        if ($response instanceof File) {
            $path = $response->getData();
            return is_string($path) && is_file($path) ? $path : '文件响应';
        }

        return $response->getContent();
    }

    /**
     * 获取业务状态码
     * @param int $responseHttpCode
     * @param array $responseData
     * @return int
     */
    public function getBusinessCode($responseHttpCode, $responseData)
    {
        if($responseHttpCode >= 400){
            return 1;
        }else{
            if(is_array($responseData)){
                if(isset($responseData['code'])){
                    return $responseData['code'];
                }
            }
            return 0;
        }
    }

    /**
     * 将操作日志异常写入独立文件，不影响业务响应
     * @param string $message
     * @return void
     */
    public function log($message)
    {
        try {
            Log::write($message, 'operation_log_error');
        } catch (Throwable $exception) {
            // 错误日志写入失败时继续执行业务
        }
    }
}
