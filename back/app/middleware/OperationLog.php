<?php

namespace app\middleware;

use app\helper\OperationLogHelper;
use app\Request;
use Closure;
use think\Response;
use Throwable;

class OperationLog
{
    /**
     * 记录请求内容、处理结果和耗时
     * @param Request $request
     * @param Closure $next
     * @param int $terminal
     * @return Response
     * @throws Throwable
     */
    public function handle(Request $request, Closure $next, int $terminal): Response
    {
        $startTime = hrtime(true);
        $operationLogHelper = new OperationLogHelper();
        $data = [
            'terminal' => $terminal,
            'api' => $request->baseUrl(),
            'request_method' => $request->method(true),
            'request_content' => $operationLogHelper->getRequestContent($request),
            'ip' => $request->ip(),
            'time' => time()
        ];

        $response = null;
        $exceptionMessage = null;
        try {
            $response = $next($request);
            return $response;
        } catch (Throwable $exception) {
            $exceptionMessage = $exception->getMessage();
            throw $exception;
        } finally {
            $data['duration'] = round((hrtime(true) - $startTime) / 1000000, 3);
            $data['user_id'] = $request->userId;
            $data['department_id'] = $request->departmentId;
            $exceptionMessage ??= $request->exceptionMessage;
            $data['result_code'] = (int) ($response?->getData()['code'] ?? ($exceptionMessage !== null ? -1 : 0));
            $data['result_content'] = $this->getResult($response, $exceptionMessage);
            $operationLogHelper->add($data);
        }
    }

    /**
     * 获取处理结果内容
     * @param Response|null $response
     * @param string|null $exceptionMessage
     * @return string
     */
    private function getResult(?Response $response, ?string $exceptionMessage): string
    {
        return $exceptionMessage ?? (string) ($response?->getData()['message'] ?? '');
    }
}
