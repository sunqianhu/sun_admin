<?php
namespace app\helper;

use app\model\ConfigModel;
use Exception;
use think\facade\Cache;

class ConfigHelper
{
    private int $id = 1;

    /**
     * 获取值
     * @param $field
     * @return mixed
     * @throws Exception
     */
    public function getValue($field)
    {
        $cacheKey = 'config_' . $field;
        $value = Cache::get($cacheKey);
        if ($value === null) {
            $configModel = ConfigModel::find($this->id);
            if (empty($configModel)) {
                throw new Exception('没有找到配置记录');
            }
            $value = $configModel->$field;
            Cache::set($cacheKey, $value, 60 * 60 * 24 * 7);
        }
        return $value;
    }

    /**
     * 设置值
     * @param $field
     * @param $value
     * @return bool
     * @throws Exception
     */
    public function setValue($field, $value)
    {
        $configModel = ConfigModel::findOrEmpty($this->id);
        $configModel->$field = $value;
        $result = $configModel->save();
        if ($result) {
            $cacheKey = 'config_' . $field;
            Cache::delete($cacheKey);
        }
        return $result;
    }
}
