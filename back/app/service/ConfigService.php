<?php
namespace app\service;

use app\model\ConfigModel;
use Exception;
use Sunqianhu\Helper\thinkphp\Crud;

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
        $configCrud = new Crud(ConfigModel::class);
        return $configCrud->selectValue($this->id, $field) ?? '';
    }

    /**
     * 设置值
     * @param $field
     * @param $value
     * @return void
     * @throws Exception
     */
    public function setValue($field, $value){
        $configCrud = new Crud(ConfigModel::class);
        $configCrud->update($this->id, [$field=>$value]);
    }
}