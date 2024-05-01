<?php

namespace app\helper\desktop;

class Module
{
    /**
     * 得到主布局第一个页面菜单id
     * @param $treeModules
     * @return int|mixed
     */
    public function getMainFirstPageId($treeModules)
    {
        foreach($treeModules as $treeModule){
            if($treeModule['layout'] == "main" && $treeModule['type_id'] == 2){
                return $treeModule['id'];
            }
            if(empty($treeModule['children'])){
                continue;
            }

            return $this->getMainFirstPageId($treeModule['children']);
        }

        return 0;
    }

    /**
     * 得到空白布局第一个页面菜单id
     * @param $treeModules 
     * @return int|mixed
     */
    public function getBlankFirstPageId($treeModules)
    {
        foreach($treeModules as $treeModule){
            if($treeModule['layout'] == "blank" && $treeModule['type_id'] == 2){
                return $treeModule['id'];
            }
            if(empty($treeModule['children'])){
                continue;
            }

            return $this->getBlankFirstPageId($treeModule['children']);
        }

        return 0;
    }
}