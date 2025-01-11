<?php

namespace app\desktop\controller\components\department;

use app\desktop\controller\Base;
use app\service\Dictionary;

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
        $dictionary = new Dictionary();
        $types = $dictionary->getList('department_type');

        return $this->success('获取成功', $types);
    }
}