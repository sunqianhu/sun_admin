<?php

namespace app\service\order;

class StatisticService
{
    /**
     * 得到时间范围内的趋势
     * @param $startTime
     * @param $endTime
     * @return array
     */
    public function getTimeRangeTrend($startTime, $endTime)
    {
        $trend = [];
        for ($time = $startTime; $time < $endTime; $time += 24 * 60 * 60) {
            $day = [
                'name' => date('j日', $time),
                'full_name' => date('Y年m月j日', $time),
                'count' => rand(0, 50)
            ];
            $trend[] = $day;
        }
        return $trend;
    }
}