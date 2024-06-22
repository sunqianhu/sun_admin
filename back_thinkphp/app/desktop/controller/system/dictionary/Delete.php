<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Dictionary as DictionaryModel;

class Delete extends Base
{
    /**
     * 删除
     *
     * @return void
     */
    public function delete()
    {
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $dictionaryModel = DictionaryModel::find($id);
        if (empty($dictionaryModel)) {
            return $this->error('没有找到记录');
        }
        $dictionaryModel->delete();

        return $this->success('删除成功');
    }
}