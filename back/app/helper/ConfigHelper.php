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
     * @return array
     * @throws Exception
     */
    public function get()
    {
        $cacheKey = 'config';
        $config = Cache::get($cacheKey);
        if ($config !== null) {
            return $config;
        }

        $configModel = ConfigModel::find($this->id);
        if (empty($configModel)) {
            throw new Exception('没有找到配置记录');
        }
        $configModel->append(['system_logo_url', 'system_favicon_url']);
        $config = $configModel->toArray();

        Cache::tag('config')->set($cacheKey, $config, 60 * 60 * 24 * 7);
        return $config;
    }

    /**
     * 修改
     * @param $data
     * @return bool
     */
    public function edit($data)
    {
        $configModel = ConfigModel::findOrEmpty($this->id);
        $result = $configModel->save($data);
        if ($result) {
            $this->clearCache();
        }
        return $result;
    }

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
        if ($value !== null) {
            return $value;
        }

        $configModel = ConfigModel::find($this->id);
        if (empty($configModel)) {
            throw new Exception('没有找到配置记录');
        }
        $value = $configModel->$field;
        Cache::tag('config')->set($cacheKey, $value, 60 * 60 * 24 * 7);

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
            $this->clearCache();
        }
        return $result;
    }

    /**
     * 获取被拒绝的ip列表
     * @return mixed
     * @throws Exception
     */
    public function getDeniedIps()
    {
        $deniedIps = Cache::get('config_denied_ips');
        if ($deniedIps !== null) {
            return $deniedIps;
        }
        $deniedIpsString = $this->getValue('denied_ips_string');
        $deniedIps = [];
        if($deniedIpsString !== ''){
            $deniedIpsString = str_replace("\r\n", "\n", $deniedIpsString);
            $deniedIps = explode("\n", $deniedIpsString);
            $deniedIps = array_filter($deniedIps);
        }
        Cache::tag('config')->set('config_denied_ips', $deniedIps, 60 * 60 * 24 * 7);
        return $deniedIps;
    }

    /**
     * 清除缓存
     * @return bool
     */
    public function clearCache()
    {
        return Cache::tag('config')->clear();
    }
}
