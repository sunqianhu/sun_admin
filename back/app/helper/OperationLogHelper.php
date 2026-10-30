<?php

namespace app\helper;

use app\model\OperationLogModel;
use Exception;
use JsonException;
use think\Request;

class OperationLogHelper
{
    /**
     * 添加操作日志
     * @param array $data
     * @return int
     * @throws Exception
     */
    public function add(array $data)
    {
        $data['time'] = $data['time'] ?? time();
        $operationLogModel = new OperationLogModel();
        $operationLogModel->save($data);

        return $operationLogModel->id;
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
        ], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_THROW_ON_ERROR);
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
}
