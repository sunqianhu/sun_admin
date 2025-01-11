<?php

namespace app\service;

use Exception;

class SingletonFactory
{
    static public $instances = [];

    /**
     * 得到实例
     * @param $class
     * @param ...$args
     * @return mixed
     * @throws Exception
     */
    static public function getInstance($class, ...$args)
    {
        if (!class_exists($class)) {
            throw new Exception("{$class}类不存在");
        }

        if (isset(self::$instances[$class])) {
            return self::$instances[$class];
        }

        $instance = new $class(...$args);
        self::$instances[$class] = $instance;
        return $instance;
    }
}