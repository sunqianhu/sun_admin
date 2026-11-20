<?php
namespace app\model;

use app\helper\SiteHelper;
use Exception;
use Sunqianhu\Helper\File;

class ConfigModel extends BaseModel
{
    protected $name = 'config';

    /**
     * 得到系统Logo访问地址
     * @param $value
     * @param $data
     * @return string
     * @throws Exception
     */
    public function getSystemLogoUrlAttr($value, $data)
    {
        if (empty($data['system_logo'])) {
            $siteHelper = new SiteHelper();
            return $siteHelper->getUrl('image/logo.png');
        }
        $file = new File();
        return $file->getUrl($data['system_logo']);
    }

    /**
     * 得到系统浏览器图标访问地址
     * @param $value
     * @param $data
     * @return string
     * @throws Exception
     */
    public function getSystemFaviconUrlAttr($value, $data)
    {
        if (empty($data['system_favicon'])) {
            $siteHelper = new SiteHelper();
            return $siteHelper->getUrl('image/favicon.ico');
        }
        $file = new File();
        return $file->getUrl($data['system_favicon']);
    }
}
