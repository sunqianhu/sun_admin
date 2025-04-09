<?php

namespace app\desktop\controller\components\department;

use app\desktop\controller\Base;
use app\service\DictionaryService;

class TypeSelect extends Base
{
    public $noApiAuthActions = [
        'getTypes'
    ];

    /**
     * 得到路由
     * @return \think\Response
     */
    public function getTypes()
    {
        $dictionaryService = new DictionaryService();
        $types = $dictionaryService->getList('department_type');

        return $this->success('获取成功', $types);
    }
}