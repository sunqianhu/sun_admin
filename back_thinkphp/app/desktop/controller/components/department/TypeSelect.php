<?php

namespace app\desktop\controller\components\department;

use app\desktop\controller\Base;
use app\service\DictionaryService;
use think\Response;

class TypeSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到路由
     * @return Response
     */
    public function getTypes()
    {
        $dictionaryService = new DictionaryService();
        $types = $dictionaryService->getList('department_type');

        return $this->success('获取成功', $types);
    }
}