<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\helper\user\UserDataScopeHelper;
use app\helper\UserHelper;
use app\validate\components\SelectUserValidate;
use Exception;
use think\exception\ValidateException;
use think\Response;

class UserSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到用户姓名
     * @return Response
     * @throws Exception
     */
    public function getUserName()
    {
        $get = $this->request->post(['user_id' => 0]);

        try {
            validate(SelectUserValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $userDataScopeHelper = new UserDataScopeHelper();
        if(!$userDataScopeHelper->canAccessUser($this->userId, 'global_user_access', $get['user_id'])){
            return $this->getErrorResponse('无权限访问该用户');
        }

        $userHelper = new UserHelper();
        $userName = $userHelper->getName($get['user_id']);

        return $this->getSuccessResponse('获取成功', $userName);
    }
}