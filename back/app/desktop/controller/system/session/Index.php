<?php

namespace app\desktop\controller\system\session;

use app\desktop\controller\Base;
use app\helper\SessionHelper;
use app\model\SessionModel;
use app\validate\PaginationValidate;
use app\validate\SessionValidate;
use Exception;
use think\exception\ValidateException;

class Index extends Base
{
    /**
     * 获取分页
     */
    public function getPaginate()
    {
        $get = $this->request->get(['name' => '', 'terminal' => '', 'user_keyword' => '', 'is_expired' => '', 'size' => 30, 'page' => 1]);

        try {
            validate(PaginationValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $query = SessionModel::alias('s')
            ->leftJoin('user u', 's.user_id = u.id')
            ->field('s.id,s.name,s.user_id,s.terminal,s.token,s.expire_time,u.name as user_name,u.account as user_account');
        if ($get['name'] !== '') {
            $query->where('s.name', 'like', '%' . $get['name'] . '%');
        }
        if ($get['terminal'] !== '') {
            if (!in_array((string) $get['terminal'], ['0', '1', '2'], true)) {
                return $this->getErrorResponse('终端参数错误');
            }
            $query->where('s.terminal', $get['terminal']);
        }
        if ($get['user_keyword'] !== '') {
            $keyword = $get['user_keyword'];
            $query->where(function ($query) use ($keyword) {
                $query->where('u.name', 'like', '%' . $keyword . '%')
                    ->whereOr('u.account', 'like', '%' . $keyword . '%');
            });
        }
        if ($get['is_expired'] !== '') {
            $query->where('s.expire_time', $get['is_expired'] == 1 ? '<=' : '>', time());
        }
        $query->order('s.id', 'desc');
        $query->append(['terminal_name']);
        $paginateObject = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $paginate = $paginateObject->toArray();

        return $this->getSuccessResponse('获取成功', $paginate);
    }

    /**
     * 删除会话
     */
    public function delete()
    {
        $post = $this->request->post(['id']);
        try {
            validate(SessionValidate::class)->scene('delete')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        try {
            $sessionHelper = new SessionHelper();
            $sessionHelper->delete($post['id']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('删除成功');
    }

    /**
     * 删除过期会话
     */
    public function deleteExpired()
    {
        try {
            $sessionHelper = new SessionHelper();
            $count = $sessionHelper->deleteExpired();
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('删除成功，共删除' . $count . '条过期会话');
    }
}
