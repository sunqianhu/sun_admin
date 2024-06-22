<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Dictionary as DictionaryModel;

class Index extends Base
{
    /**
     * 得到字典集合
     */
    public function getDictionarys()
    {
        $get = $this->request->get(['type' => '', 'key' => '', 'value' => '', 'size' => '30', 'page' => '1']);
        $query = DictionaryModel::field('id,type,key,value,sort');
        if ($get['type'] !== '') {
            $query = $query->where('type', 'LIKE', '%' . $get['type'] . '%');
        }
        if ($get['key'] !== '') {
            $query = $query->where('key', 'LIKE', '%' . $get['key'] . '%');
        }
        if ($get['value'] !== '') {
            $query = $query->where('value', 'LIKE', '%' . $get['value'] . '%');
        }
        $query = $query->order([
            'type' => 'asc',
            'sort' => 'asc'
        ]);
        $dictionarys = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        return $this->success('获取成功', $dictionarys);
    }
}