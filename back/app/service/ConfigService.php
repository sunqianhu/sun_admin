<?php
namespace app\service;

use app\model\ConfigModel;
use Exception;

class ConfigService
{
    private int $id = 1;

    /**
     * 得知值
     * @param $field
     * @return mixed
     * @throws Exception
     */
    public function getValue($field)
    {
        $configModel = ConfigModel::find($this->id);
        if(empty($configModel)){
            throw new Exception('没有找到配置记录');
        }
        return $configModel->$field;
    }

    /**
     * 设置值
     * @param $field
     * @param $value
     * @return bool
     * @throws Exception
     */
    public function setValue($field, $value){
        $configModel = ConfigModel::find($this->id);
        if(empty($configModel)){
            throw new Exception('没有找到配置记录');
        }
        $configModel->$field = $value;
        return $configModel->save();
    }
}