<?php

namespace app\desktop\controller\components\department;

use app\desktop\controller\Base;
use app\helper\DictionaryHelper;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class TypeSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到路由
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTypes()
    {
        $dictionaryHelper = new DictionaryHelper();
        $types = $dictionaryHelper->getList('department_type');

        return $this->getSuccessResponse('获取成功', $types);
    }
}