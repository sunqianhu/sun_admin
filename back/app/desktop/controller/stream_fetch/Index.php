<?php

namespace app\desktop\controller\stream_fetch;

use app\desktop\controller\Base;

class Index extends Base
{
    /**
     * 提取
     * @return void
     */
    public function fetch()
    {
        set_time_limit(600);

        //不缓存立即输出
        header('Content-Type: text/event-stream');
        header('Cache-Control: no-cache');
        header('X-Accel-Buffering: no');
        header('Connection: keep-alive');
        if (ob_get_level()) {
            ob_end_clean();
        }

        $result = '###  关于高效工作的思考

在这个信息爆炸的时代，**专注力**已经成为了一种稀缺资源。我们每天被无数的通知、邮件和消息轰炸，很难有大块的深度工作时间。

> “你的时间有限，所以不要为别人而活。不要被教条所限，不要活在别人的观念里。” —— 史蒂夫·乔布斯

#### 核心原则

为了保持高效，我们需要遵循一些基本原则：

1.  **要事第一**：每天早晨列出最重要的三件事，优先完成它们。
2.  **学会拒绝**：不要对所有请求都说“是”，保护你的时间。
3.  **定期复盘**：每周回顾一下自己的产出，看看是否在向目标靠近。

#### 推荐工具

以下是一些能提升效率的工具：

-   **Notion**：用于构建个人知识库。
-   **Slack**：团队沟通协作。
-   **Trello**：看板管理任务进度。

#### 代码示例

如果你是一名开发者，可能需要在文档中插入代码。Markdown 支持语法高亮：

```python
def calculate_efficiency(focus_hours, total_hours):
    if total_hours == 0:
        return 0
    return (focus_hours / total_hours) * 100

score = calculate_efficiency(4, 8)
print(f"今日专注效率: {score}%")';
        $data = [
            'event'=>'text_chunk',
            'message'=>'',
        ];
        $length = mb_strlen($result, 'UTF-8');
        for ($i = 0; $i < $length; $i++) {
            $char = mb_substr($result, $i, 1, 'UTF-8');
            $data['message'] = $char;
            echo 'data: '.json_encode($data)."\n\n";
            flush();
            usleep(1000 * 30);
        }
        exit;
    }
}