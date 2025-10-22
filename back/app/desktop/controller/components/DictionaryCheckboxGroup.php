<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\service\DictionaryService;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class DictionaryCheckboxGroup extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到字典
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getDictionary()
    {
        $type = $this->request->get('type', '');
        if($type === ''){
            return $this->getErrorResponse('字典类型不能为空');
        }

        $dictionaryService = new DictionaryService();
        $dictionary = $dictionaryService->getList($type);

        return $this->getSuccessResponse('获取成功', $dictionary);
    }
}