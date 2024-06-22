<?php

namespace app\entity;

class Watermark
{
    public $userId = 0;
    public $userName = '';
    public $dateTime = '';

    /**
     * 转数组
     * @return array
     */
    public function toArray(){
        $data = [
            'user_id'=>$this->userId,
            'user_name'=>$this->userName,
            'date_time'=>$this->dateTime
        ];
        return $data;
    }
}