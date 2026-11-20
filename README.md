# sun admin 管理系统模板

sun admin 是一个前后端分离的管理系统开发基座，包含 ThinkPHP 后端、Vue 桌面端和 Vue 移动端。项目提供用户、单位、角色、功能权限、数据权限、菜单路由、会话、日志和消息等基础能力，开发新系统时可以在此基础上增加业务模块。

## 目录

- [技术栈](#技术栈)
- [系统架构](#系统架构)
- [功能模块](#功能模块)
- [快速开始](#快速开始)
- [环境配置](#环境配置)
- [认证与接口响应](#认证与接口响应)
- [权限配置](#权限配置)
- [新增业务模块](#新增业务模块)
- [桌面端组件](#桌面端组件)
- [移动端组件](#移动端组件)
- [前端工具与状态管理](#前端工具与状态管理)
- [后端助手类](#后端助手类)
- [消息与队列](#消息与队列)
- [操作日志](#操作日志)
- [缓存管理](#缓存管理)
- [主题与布局](#主题与布局)
- [自动化测试](#自动化测试)
- [构建与部署](#构建与部署)
- [GitLab CI 与版本号](#gitlab-ci-与版本号)
- [开发约定](#开发约定)
- [常见问题](#常见问题)

## 技术栈

| 部分 | 主要技术 | 用途 |
| --- | --- | --- |
| 后端框架 | ThinkPHP 8、ThinkORM 4、ThinkPHP 多应用 | HTTP 接口、数据库访问、按终端组织控制器 |
| 后端辅助能力 | JWT、think-queue 3、Workerman 4、PhpSpreadsheet、sunqianhu/helper | 会话凭据、队列、WebSocket、Excel 和常用工具 |
| 缓存与队列存储 | Redis、PHP Redis 扩展 | 缓存和队列共用 Redis 服务，分别使用独立 DB |
| 桌面端 | Vue 3.5、Vue Router 4、Pinia、Element Plus 2 | 管理界面、动态路由、状态管理 |
| 桌面端扩展 | ECharts 5、wangEditor 5、Axios、Day.js、Sass | 图表、富文本、请求、时间和样式 |
| 移动端 | Vue 3.5、Vue Router、Pinia、Vant 4、Axios | 移动界面和公共组件 |
| 前端构建 | Vite 6 | 开发服务器和生产构建 |
| 测试 | PHPUnit 11.5 | 后端测试 |
| 交付 | Docker、Nginx、Supervisor、GitLab CI、Harbor | 容器运行、进程管理、测试和镜像交付 |

建议使用 PHP 8.2、Composer 2，以及支持 Vite 6 的 Node.js 版本。仓库 Dockerfile 使用 PHP 8.2 和 Node.js 24.3.0。虽然后端 `composer.json` 声明 PHP `>=8.0`，当前 PHPUnit 11 需要 PHP 8.2。

默认数据库为 MySQL，部署示例使用 MySQL 5.7.44。缓存和队列默认使用 Redis，需要 PHP Redis 扩展。默认缓存使用 Redis DB 0，队列使用 DB 1。

依赖的准确版本以 [back/composer.lock](back/composer.lock)、[front/package-lock.json](front/package-lock.json) 和 [front_mobile/package-lock.json](front_mobile/package-lock.json) 为准。

## 系统架构

### 三端共用一个后端基础体系

桌面端、移动端和 API 端共用用户、角色、功能权限、数据权限及会话数据。控制器按应用划分，公共逻辑放在助手类中复用。

~~~mermaid
flowchart TD
    D["桌面端 Vue + Element Plus"] --> H["HTTP / JSON 接口"]
    M["移动端 Vue + Vant"] --> H
    A["外部 API 调用方"] --> H
    H --> L["操作日志中间件"]
    L --> B["各应用 Base：IP、会话和接口权限认证"]
    B --> C["控制器：验证、事务与响应"]
    C --> V["Validate：参数验证"]
    C --> P["Helper：可复用业务操作"]
    P --> O["Model / Query"]
    O --> DB[("MySQL")]
    P --> CACHE["Redis 缓存 DB 0"]
    P --> Q["Redis 队列 DB 1"]
    Q --> W["消息队列 Worker"]
    W --> WS["Workerman WebSocket"]
    WS --> D
~~~

操作日志中间件在请求进入时采集请求信息，在取得响应后读取认证产生的会话、用户和单位信息，记录响应及耗时。身份认证目前在各应用 Base 控制器中执行。

### 目录结构

~~~text
.
├─ back/
│  ├─ app/
│  │  ├─ api/controller/       API 端控制器
│  │  ├─ desktop/controller/   桌面端控制器
│  │  ├─ mobile/controller/    移动端控制器
│  │  ├─ command/             命令行任务和 WebSocket 服务
│  │  ├─ helper/              业务助手类
│  │  ├─ job/                 队列任务
│  │  ├─ middleware/          操作日志中间件
│  │  ├─ model/               数据模型、关联与访问器
│  │  ├─ validate/            参数验证器
│  │  ├─ ExceptionHandle.php  异常响应处理
│  │  └─ Request.php          请求扩展与可信代理设置
│  ├─ config/                 应用、数据库、缓存、队列和日志配置
│  ├─ docker/                 容器环境配置和进程管理
│  ├─ public/                 HTTP 服务入口
│  │  └─ storage/             默认上传文件目录
│  ├─ runtime/                缓存、日志等运行数据
│  ├─ tests/                  PHPUnit 测试
│  ├─ phpunit.xml             PHPUnit 配置
│  └─ Dockerfile
├─ front/
│  ├─ src/
│  │  ├─ assets/              公共样式、主题和静态资源
│  │  ├─ components/          公共组件
│  │  ├─ helper/              HTTP、会话、权限、缓存等工具
│  │  ├─ layouts/             main 和 blank 路由布局
│  │  ├─ router/              静态路由和动态路由注册
│  │  ├─ stores/              Pinia 状态
│  │  └─ views/               管理页面及开发模板
│  ├─ docker/                 Nginx 配置
│  └─ Dockerfile
├─ front_mobile/
│  ├─ src/
│  │  ├─ components/          移动端公共组件
│  │  ├─ helper/              移动端工具
│  │  └─ views/               登录、首页、个人信息等页面
│  └─ Dockerfile
├─ 资料/部署/
│  ├─ sun_admin.sql           初始化结构和基础数据
│  └─ docker-compose.yml      部署示例
└─ .gitlab-ci.yml             测试、构建、打包、镜像推送
~~~

### 后端分层职责

| 层 | 职责 | 示例 |
| --- | --- | --- |
| Controller | 接收参数、调用验证器、组织助手、处理跨资源事务、返回响应 | 角色保存时依次保存角色及各类授权关系 |
| Validate | 验证字段和场景，返回明确的参数错误 | `PaginationValidate`、`SessionValidate` |
| Helper | 封装自己负责的资源操作及可复用逻辑 | `RoleHelper::edit()`、`RolePolicyHelper::deleteByRoleId()` |
| Model | 表映射、模型关联、访问器等 | `UserModel`、`RolePolicyModel` |
| Middleware | 执行跨请求的公共处理 | `OperationLog` 采集请求和响应 |
| Job / Command | 执行队列任务、常驻服务或命令行工作 | 消息队列任务、WebSocket 服务 |

助手只处理自己负责的资源。例如删除角色时，由控制器在事务中调用角色、权限关系、菜单关系、路由关系、策略关系和用户关系的助手；`RoleHelper::delete()` 本身只删除角色记录。

### 前端运行流程

1. 登录页面请求后端，取得会话令牌并通过 `login(token)` 保存。
2. 路由守卫检查本地 token，再加载当前用户的功能权限和动态路由。
3. 路由配置的 `component_path` 映射到 `views` 下的 Vue 文件，按 `main` 或 `blank` 挂载。
4. 主布局加载用户可用菜单，业务页面通过公共请求工具访问接口。
5. 请求头自动携带 token；身份失效时清理前端登录状态并跳转登录页。

Pinia 保存当前页面运行所需状态，部分路由、权限和水印数据还通过 localStorage 缓存。前端显示权限与后端接口校验分别执行。

### 数据库基础结构

| 领域 | 主要数据表 | 关系说明 |
| --- | --- | --- |
| 组织和用户 | `department`、`user`、`user_role`、`role` | 用户属于单位，通过用户角色关系获得一个或多个角色 |
| 功能权限 | `permission`、`role_permission` | 角色绑定功能权限，权限记录包含标识和接口列表 |
| 数据权限 | `data_scope`、`data_scope_policy`、`data_scope_policy_department`、`role_policy` | 数据权限包含策略，角色绑定策略，指定单位单独维护关联 |
| 桌面入口 | `desktop_menu`、`desktop_route`、`role_desktop_menu`、`role_desktop_route` | 菜单和路由分别保存，并分别授权角色 |
| 登录和会话 | `session`、`login_log` | 会话保留终端和过期时间，登录日志保留登录记录 |
| 消息和队列 | `message`、`jobs`、`failed_jobs` | 消息存入 MySQL，任务默认存入 Redis；`jobs` 保留用于数据库驱动，失败任务是否入库由配置决定 |
| 设置和运行记录 | `config`、`dictionary`、`runtime`、`operation_log` | 系统配置、字典、运行值及操作审计 |

表结构和初始化关系以 [sun_admin.sql](资料/部署/sun_admin.sql) 为准。当前队列的失败任务存储类型配置为 `none`，不能仅因存在 `failed_jobs` 表就认为失败任务已自动入库。

## 功能模块

### 系统管理

| 模块 | 当前能力 | 桌面页面 |
| --- | --- | --- |
| 用户管理 | 添加、修改、查看用户，分配单位和角色，修改密码、状态，按桌面/移动/API 终端踢下线 | [system/user](front/src/views/system/user) |
| 单位管理 | 维护单位树、上级关系及单位路径 | [system/department](front/src/views/system/department) |
| 角色管理 | 在添加/修改角色时集中设置功能权限、数据权限策略、桌面菜单和桌面路由 | [system/role](front/src/views/system/role) |
| 功能权限 | 维护统一权限标识及对应的接口列表 | [system/permission](front/src/views/system/permission) |
| 数据权限 | 定义数据权限项，配置本用户、本单位、指定单位等策略 | [system/data_scope](front/src/views/system/data_scope) |
| 桌面菜单 | 维护菜单树、图标、排序和跳转地址；图标按实际图形展示 | [system/desktop/menu](front/src/views/system/desktop/menu) |
| 桌面路由 | 维护页面路径、组件路径、布局和缓存设置 | [system/desktop/route](front/src/views/system/desktop/route) |
| 字典管理 | 维护字典类型、键、值和排序，供表单和列表复用 | [system/dictionary](front/src/views/system/dictionary) |
| 会话管理 | 管理三端会话，支持添加、删除、续期、复制令牌、按过期状态筛选及删除过期会话 | [system/session](front/src/views/system/session) |
| 登录日志 | 查看登录用户、终端、IP 和时间 | [system/login_log](front/src/views/system/login_log) |
| 操作日志 | 查看请求方法、内容、HTTP 状态码、业务码、响应、会话及耗时，按时间段删除 | [system/operation_log](front/src/views/system/operation_log) |
| 系统消息 | 查看消息、未读数量、设置已读，配合 WebSocket 接收提醒 | [system/message](front/src/views/system/message) |
| 系统设置 | 设置系统名称、Logo、浏览器图标、系统简介和禁止访问的 IP | [system/config](front/src/views/system/config) |

### 框架界面与个人功能

- 主布局支持侧边栏和顶部导航两种形式，也提供空白布局。
- 支持明暗主题、主题设置、快捷导航、全屏和水印。
- 头像菜单提供账号信息、修改密码、修改头像、关于系统和退出等入口。
- 关于系统以弹窗显示系统名称、简介及版本；系统简介在系统设置中维护，最多 5000 字。
- 版本显示在登录页面、主布局系统名称下方及关于系统中。

### 移动端与 API 端

移动端当前提供登录、首页、个人信息和头像等基础页面，以及 Vant 公共组件。完整的桌面管理模块没有逐一复制到移动端。

API 端与其他终端共用会话、角色和权限。外部程序使用终端值为 `2` 的会话令牌调用接口，接口控制器位于 [back/app/api/controller](back/app/api/controller)。

### 示例与模板

| 内容 | 用途 |
| --- | --- |
| [桌面开发模板](front/src/views/template) | 列表、添加、修改、详情、空白页面的复制起点 |
| [后端开发模板](back/app/desktop/controller/template) | 控制器参数验证、分页和响应写法 |
| [移动开发模板](front_mobile/src/views/template/Base.vue) | 移动页面基础结构 |
| [订单趋势](front/src/views/statistic/OrderTrend.vue) | 图表和 Excel 导出示例，统计助手当前使用随机演示数据 |
| [流式请求](front/src/views/stream_fetch/Index.vue) | 流式请求工具的调用示例 |
| [桌面 Test 页面](front/src/views/Test.vue) | 开发时验证组件和交互 |

后端模板保留字典模块命名空间，复制后需要替换命名空间、模型、验证器及接口地址。

### 常用管理流程

**新增可用账号：** 先维护单位，再创建角色并分配菜单、路由、功能权限和数据策略，最后在用户管理中创建用户、选择单位和角色。新用户登录后看到的入口和可访问的数据由这些配置共同决定。

**修改系统信息：** 在系统设置中修改名称、Logo、浏览器图标和简介；关于系统读取同一份简介。Logo 支持 PNG、JPG、GIF，上传并保存后刷新页面，登录页、侧边栏和顶部导航栏会显示新 Logo；未设置时使用后端 `back/public/image/logo.png`，由 `ConfigModel` 获取器通过 `SiteHelper` 生成访问地址。应用版本来自构建，不在系统设置中手动维护。

浏览器图标使用独立的 `system_favicon` 字段。在本地制作好 `.ico` 文件后上传，最大 2 MB，保存并刷新页面后生效。未上传时使用后端 `back/public/image/favicon.ico`；`system_favicon_url` 由 `ConfigModel` 获取器生成。桌面端和移动端的 `index.html` 使用固定入口 `desktop/Favicon/index`，后端通过 HTTP 302 跳转到当前图标文件，上传后无需重新构建前端。已有数据库需执行 [system_favicon.sql](资料/部署/system_favicon.sql) 增加字段。

**创建 API 凭据：** 在会话管理中添加会话，终端选择 API 端，填写所属用户、名称和过期时间。添加后复制令牌，调用 API 时放入 `token` 请求头。该会话沿用所属用户的角色权限，不单独建立另一套授权。

**清理会话和日志：** 会话管理可删除指定记录或批量删除过期会话；操作日志按选定时间段删除。删除过期会话使用现有的 `session_delete` 权限，不另设一项功能权限。

## 快速开始

### 1. 准备运行环境

准备 PHP 8.2、Composer 2、Node.js、npm、MySQL 和 Redis，并启用 PHP Redis 扩展。PHP 需要相应的数据库及扩展支持；使用 Excel、图片处理等功能时也要安装所需扩展。可参考 [后端 Dockerfile](back/Dockerfile) 的运行环境。

以下命令均从仓库根目录开始，按目录分别执行。初次运行需要同时准备后端和至少一个前端。

启动后端前，确认 Redis 服务已运行，并检查当前命令行 PHP 是否已启用 Redis 扩展：

~~~sh
php --ri redis
~~~

使用 PHP-FPM 部署时，也要确保 PHP-FPM 所用的 PHP 环境启用了该扩展。

### 2. 初始化数据库

1. 创建项目数据库。
2. 导入 [资料/部署/sun_admin.sql](资料/部署/sun_admin.sql)。
3. 在后端环境文件中填写数据库连接。

SQL 包含表结构和系统基础数据。账号明文密码请向项目维护者确认，或自行初始化；本文不约定默认密码。

初始化 SQL 用于新数据库。升级已有系统时应编写并执行对应的增量 SQL，不能重新导入初始化脚本覆盖现有数据。

### 3. 配置并启动后端

编辑 `back/.env`，最小配置示例：

~~~dotenv
APP_DEBUG=true
APP_JWT_KEY=replace_with_your_own_random_key

DB_TYPE=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=your_database
DB_USER=your_user
DB_PASS=your_password
DB_CHARSET=utf8mb4
DB_PREFIX=

REDIS_HOST=127.0.0.1
REDIS_PORT=6379
REDIS_PASSWORD="your_redis_password"
REDIS_DB_CACHE=0
REDIS_DB_QUEUE=1
~~~

初始化 SQL 使用无前缀表名，通常保持 `DB_PREFIX` 为空。

`REDIS_PASSWORD` 填写实际 Redis 密码，包含 `#`、空格等字符时用引号包裹；未设置密码时留空。缓存和队列应使用不同的 Redis DB，并为本站预留，避免清理缓存时影响队列或其他应用。

Redis 不需要导入初始化 SQL。用户、会话、消息及日志等业务数据仍存入 MySQL，Redis 用于缓存和待处理队列任务。

~~~sh
cd back
composer install
php think run --host 0.0.0.0 --port 8000
~~~

后端开发地址为 `http://127.0.0.1:8000`，文档根目录为 `back/public`。内置服务器用于本地开发，生产环境使用 Nginx 和 PHP-FPM。

### 4. 配置并启动桌面端

在 [front/.env.development](front/.env.development) 中确认：

~~~dotenv
VITE_BASE=/
VITE_API_PREFIX=/api/
VITE_PROXY_PREFIX=/api/
VITE_PROXY_TARGET=http://127.0.0.1:8000
VITE_WEBSOCKET_MESSAGE_URL=ws://127.0.0.1:7001
~~~

~~~sh
cd front
npm ci
npm run dev
~~~

打开 `http://localhost:5179`。如果依赖清单有变化，需要先更新并提交对应的 lock 文件。

### 5. 启动移动端

在 [front_mobile/.env.development](front_mobile/.env.development) 中配置相同的后端代理：

~~~dotenv
VITE_BASE=/
VITE_API_PREFIX=/api/
VITE_PROXY_PREFIX=/api/
VITE_PROXY_TARGET=http://127.0.0.1:8000
~~~

~~~sh
cd front_mobile
npm ci
npm run dev
~~~

打开 `http://localhost:5174`。使用手机访问时，将地址中的 `localhost` 换为开发电脑在局域网中的 IP。

### 6. 启动消息服务

需要测试系统消息时，再开启两个独立终端：

~~~sh
cd back
php think message
~~~

~~~sh
cd back
php think queue:work --queue=message --tries=3 --delay=30
~~~

WebSocket 服务和队列 Worker 是两个进程，前端 Vite 服务不会自动启动它们。容器部署时由 Supervisor 管理，见后文。

## 环境配置

### 后端环境变量

| 变量 | 作用 | 默认值或说明 |
| --- | --- | --- |
| `APP_DEBUG` | 调试模式 | 生产环境设为 `false` |
| `APP_JWT_KEY` | JWT 签名密钥 | 需自行配置 |
| `APP_HOST` | 应用地址配置 | 默认空 |
| `DB_DRIVER` | 数据库连接配置名 | `mysql` |
| `DB_TYPE` | 数据库类型 | `mysql` |
| `DB_HOST` / `DB_PORT` | 数据库主机、端口 | `127.0.0.1` / `3306` |
| `DB_NAME` / `DB_USER` / `DB_PASS` | 数据库名称、用户和密码 | 按环境填写 |
| `DB_CHARSET` / `DB_PREFIX` | 数据库字符集、表前缀 | 默认 `utf8` / 空 |
| `REDIS_HOST` / `REDIS_PORT` | 缓存和队列共用的 Redis 地址、端口 | `127.0.0.1` / `6379` |
| `REDIS_PASSWORD` | Redis 密码 | 未设置密码时留空 |
| `REDIS_DB_CACHE` | 缓存使用的 Redis DB | `0` |
| `REDIS_DB_QUEUE` | 队列使用的 Redis DB | `1`，与缓存分开 |
| `FILE_ROOT_PATH` | 上传文件物理根目录 | `back/public/storage/` |
| `FILE_ACCESS_PREFIX` | 上传文件访问前缀 | `/api/storage/` |
| `SITE_ROOT_PATH` | 站点物理根目录 | `back/public/` |
| `SITE_ACCESS_PREFIX` | 站点访问前缀 | `/api/` |
| `MESSAGE_LISTEN_IP` | WebSocket 服务监听地址 | `0.0.0.0` |
| `MESSAGE_REQUEST_IP` | 后端发送助手连接 WebSocket 服务的地址 | `127.0.0.1` |
| `MESSAGE_PORT` | WebSocket 服务端口 | `7001` |

`FILE_ROOT_PATH` 和 `SITE_ROOT_PATH` 是服务器磁盘路径；`FILE_ACCESS_PREFIX` 和 `SITE_ACCESS_PREFIX` 是浏览器访问路径。更改部署前缀时需同步检查这两组配置。

配置入口：[app.php](back/config/app.php)、[database.php](back/config/database.php)、[cache.php](back/config/cache.php)、[queue.php](back/config/queue.php)、[file.php](back/config/file.php)、[site.php](back/config/site.php)、[message.php](back/config/message.php)。

### 环境文件的使用位置

| 文件 | 使用场景 |
| --- | --- |
| `back/.env` | 本地后端和本地 PHPUnit |
| `back/docker/.env` | 后端 Dockerfile 复制到镜像内的环境配置 |
| `back/docker/.env_test` | GitLab CI 测试容器挂载的环境配置 |
| `front/.env.development` / `front_mobile/.env.development` | 前端开发服务器 |
| `front/.env.production` / `front_mobile/.env.production` | 前端正式构建 |

修改本地 `back/.env` 不会自动修改 Docker 和 CI 的环境配置。

Docker 环境默认通过 `host.docker.internal` 访问宿主机已有的 Redis，Compose 已配置该地址映射。CI 测试使用 Runner 可访问的 Redis 地址；分别在对应环境文件填写地址和密码。

| 运行位置 | Redis 连接配置 |
| --- | --- |
| 本地 PHP | 在 `back/.env` 配置，默认连接 `127.0.0.1:6379` |
| Docker 后端 | 在 `back/docker/.env` 配置，默认连接宿主机的 `host.docker.internal:6379` |
| GitLab CI 测试 | 在 `back/docker/.env_test` 配置，地址必须能从 Runner 访问 |

三个环境分别读取自己的配置文件。本地填写密码后，Docker 和 CI 的密码仍需要按各自连接的 Redis 配置。

### 前端变量与代理

| 变量 | 作用 |
| --- | --- |
| `VITE_BASE` | 前端资源与路由基础路径 |
| `VITE_API_PREFIX` | 浏览器请求接口时增加的前缀 |
| `VITE_PROXY_PREFIX` | 开发服务器需要代理的路径前缀 |
| `VITE_PROXY_TARGET` | 开发代理目标后端 |
| `VITE_BUILD_OUTDIR` | 构建产物目录，正式环境配置为 `dist` |
| `VITE_WEBSOCKET_MESSAGE_URL` | 桌面消息连接地址；HTTPS 站点应使用 `wss://` |

开发请求示例：

~~~text
页面调用：desktop/system.user.Index/getPaginate
浏览器请求：/api/desktop/system.user.Index/getPaginate
Vite 转发：http://127.0.0.1:8000/desktop/system.user.Index/getPaginate
~~~

前端 `VITE_*` 值会进入浏览器构建产物，供前端读取。生产构建后调整这些值需要重新构建。

## 认证与接口响应

### 会话与终端

当前使用请求头 `token` 传递令牌：

~~~http
token: <会话令牌>
~~~

| 终端 | 值 | 登录有效期与续期 |
| --- | --- | --- |
| 桌面端 | `0` | 登录有效期 30 分钟，正常认证后自动续期至当前时间后 30 分钟 |
| 移动端 | `1` | 登录有效期 7 天，正常认证后自动续期至当前时间后 7 天 |
| API 端 | `2` | 使用会话设置的过期时间，不自动续期 |

令牌由 JWT 生成，但认证同时查询服务端 `session` 记录及用户状态。删除会话后，后续 HTTP 请求无法继续使用该会话。

会话没有 `status` 字段。删除会话就是使凭据失效；账号退出及用户管理中的踢下线均通过删除会话实现。修改密码本身不删除会话，修改账号状态也不删除会话记录；停用账号会在后续认证时被拒绝。

### Base 的认证流程

三端的 [desktop/Base](back/app/desktop/controller/Base.php)、[mobile/Base](back/app/mobile/controller/Base.php) 和 [api/Base](back/app/api/controller/Base.php) 在 `initialize()` 中执行认证：

1. 检查访问 IP。
2. 根据控制器设置，读取 `token` 并调用 `SessionHelper::tokenAuth(terminal, token)`。
3. 在当前 Request 写入 `sessionId`、`userId` 和 `departmentId`。
4. 桌面端、移动端按各自时长续期。
5. 根据控制器设置检查当前接口是否在用户功能权限的接口列表中。

业务控制器可直接读取：

~~~php
$userId = $this->request->userId;
$sessionId = $this->request->sessionId;
$departmentId = $this->request->departmentId;
~~~

控制器认证开关：

~~~php
public bool $isTokenAuth = true;
public array $noTokenAuthActions = [];
public bool $isApiAuth = true;
public array $noApiAuthActions = [];
~~~

需要登录但不检查功能权限的接口，可设置 `$isApiAuth = false`。登录等公开接口按现有控制器设置 `$isTokenAuth` 或动作白名单。普通业务接口保留默认认证。

### JSON 响应约定

~~~json
{
  "code": 0,
  "message": "获取成功",
  "data": {}
}
~~~

| 业务码 | 含义 |
| --- | --- |
| `0` | 成功 |
| `1` | 业务失败 |
| `2` | 身份认证失败，前端退出当前登录状态 |

控制器调用：

~~~php
return $this->getSuccessResponse('保存成功', $data);
return $this->getErrorResponse('没有找到记录');
return $this->getErrorResponse('身份认证失败', null, 2);
~~~

这两个方法的最后一个参数是 HTTP 状态码，默认 `200`。业务码与 HTTP 状态码分别表示业务处理结果和 HTTP 请求结果。

Base 在初始化阶段通过 `HttpResponseException` 携带响应中止控制器执行。未主动转换的普通异常交给 ThinkPHP 默认异常处理器，可能返回错误页面；文件下载、流式响应也不使用上述 JSON 结构。

### 前端请求约定

~~~js
import axios from "@/helper/axios";

const response = await axios.get("desktop/system.user.Index/getPaginate", {
  params: { page: 1, size: 30 },
});

if (response.code != 0) {
  ElMessage({ message: response.message, type: "error" });
  return;
}

const users = response.data.data;
const total = response.data.total;
~~~

`@/helper/axios` 已自动增加接口前缀和 `token`，返回值是业务 JSON。这里的 `response.data` 是业务数据，不是原生 Axios Response。

业务码 `2` 由拦截器处理登录失效；一般业务失败由页面检查 `code`。网络或 HTTP 错误会使 Promise 拒绝，调用方需要按界面需求处理，并在 `finally` 中结束 loading。

## 权限配置

### 四种配置分别负责什么

| 配置 | 解决的问题 | 主要数据表 |
| --- | --- | --- |
| 功能权限 | 用户能否执行某项功能、调用某个接口 | `permission`、`role_permission` |
| 桌面菜单 | 用户导航中显示哪些入口 | `desktop_menu`、`role_desktop_menu` |
| 桌面路由 | 用户能加载哪些业务页面 | `desktop_route`、`role_desktop_route` |
| 数据权限 | 用户在允许的功能中能操作哪些记录 | `data_scope`、`data_scope_policy`、`role_policy` |

菜单可见、路由可用、接口可调用是不同的配置。新增模块后，需要分别配置并授予角色。

### 功能权限

功能权限全站统一管理，标识可以使用 `order_view`、`order_add` 等，不要求添加终端前缀。

`permission.apis_string` 每行填写一个后端接口路径，例如：

~~~text
/desktop/business.order.Index/getPaginate
/desktop/business.order.Detail/init
~~~

接口认证将请求的 `$request->baseUrl()` 与权限列表进行小写比较。路径应与后端实际收到的路径一致：保留开头的 `/`，不包含开发代理剥离的 `/api/`。

一个权限可以包含多个接口。同一业务功能的桌面端、移动端和 API 端接口可以归到同一权限下。

### 桌面路由和菜单

桌面端业务路由由管理页面维护，再由 [router/index.js](front/src/router/index.js) 动态注册。通常不需要为每个新模块修改静态路由文件。

新增路由示例：

| 字段 | 示例 |
| --- | --- |
| 页面路径 `path` | `/business/order` |
| 标识 `key` | `business_order` |
| 组件路径 `component_path` | `business/order/Index.vue` |
| 布局 | `main` 或 `blank` |
| 页面缓存 | 按需设置 |

组件路径相对于 `front/src/views/`，不写 `@/views/`。目标文件需要在前端构建时存在，动态路由配置不会动态下载新写入的 Vue 源码。

随后在桌面菜单管理中配置菜单名称、图标及跳转路径，并在角色中同时授予对应菜单和路由。

### 数据权限与策略

数据权限项表示一类数据访问能力，例如 `global_user_access`、`global_department_access`。策略属于某个数据权限项，角色通过 `role_policy(role_id, policy_id)` 直接绑定策略。

~~~mermaid
flowchart LR
    U["用户"] --> UR["user_role"] --> R["角色"]
    R --> RP["role_policy"] --> P["data_scope_policy"]
    P --> DS["data_scope"]
    P --> PD["data_scope_policy_department"]
    PD --> D["指定单位"]
~~~

| 策略类型 | type | 含义 |
| --- | --- | --- |
| 本用户 | `0` | 仅当前用户对应的数据 |
| 本单位 | `1` | 当前用户所属单位的数据 |
| 本单位及下级单位 | `2` | 当前单位和其下级单位的数据 |
| 指定单位 | `98` | 策略中选定单位的数据 |
| 全部 | `99` | 不增加数据范围限制 |
| 无权限 | `100` | 不授予数据访问 |

“指定单位”在策略中配置单位，角色只选择策略，前端提交 `policy_ids`。多个角色产生的允许规则按 OR 合并；“无权限”不是覆盖其他允许规则的显式拒绝。

配置数据权限后，业务查询仍需要调用助手增加约束：

~~~php
use app\helper\user\UserDataScopeHelper;
use app\model\UserModel;

$query = UserModel::alias('u');
$userDataScopeHelper = new UserDataScopeHelper();
$query = $userDataScopeHelper->buildQueryConstraint(
    $this->request->userId,
    'global_user_access',
    $query,
    'u.department_id',
    'u.id'
);
~~~

`departmentField` 和 `userField` 应填写当前业务表对应的单位、用户字段，使用表别名时也要带别名。部门资源没有用户归属字段时，不适用“本用户”策略；空用户字段不会被当作无条件允许。

现有用户和单位记录还可通过 `canAccessUser()`、`canAccessDepartment()` 检查。详情、修改和删除同样需要检查目标记录的数据范围，仅过滤列表不足以完成数据权限控制。

### 前端按钮权限

~~~vue
<el-button v-permission="['order_add']" @click="openAdd">
  添加
</el-button>
~~~

需要在脚本判断时：

~~~js
import { hasPermission } from "@/helper/permission";

const canEdit = hasPermission(["order_edit"]);
~~~

`hasPermission(keys)` 要求传入的所有权限都满足。前端控制显示，后端接口权限和数据权限负责实际访问控制。

## 新增业务模块

以新增订单管理为例，推荐按以下顺序实施。

### 1. 建表和后端分层

- 创建业务表和 `OrderModel`。
- 创建 `OrderValidate`，分别定义添加、修改等验证场景。
- 创建 `OrderHelper`，封装订单自身的添加、修改和删除。
- 在 `back/app/desktop/controller/business/order/` 下增加列表、添加、修改等控制器，并继承桌面 Base。
- 跨表关联由控制器调用相应助手，使用事务保持保存或删除的一致性。

可从 [后端模板](back/app/desktop/controller/template) 复制结构。示例中的 Order 类和目录是新模块命名示意，需要自行创建。

### 2. 每个分页接口应用分页验证器

~~~php
use app\validate\PaginationValidate;
use think\exception\ValidateException;

$get = $this->request->get([
    'page' => '1',
    'size' => '30',
]);

try {
    validate(PaginationValidate::class)->check($get);
} catch (ValidateException $exception) {
    return $this->getErrorResponse($exception->getError());
}

$paginate = $query->paginate([
    'list_rows' => $get['size'],
    'page' => $get['page'],
])->toArray();

return $this->getSuccessResponse('获取成功', $paginate);
~~~

此处 `$query` 是已建立查询条件的数据查询对象。验证规则是 `page` 为正整数、`size` 为 `1–300` 的整数。验证器位于 [PaginationValidate.php](back/app/validate/PaginationValidate.php)，需要在分页接口显式调用，不是由 Base 自动执行。

### 3. 创建前端页面

从 [front/src/views/template](front/src/views/template) 复制页面到 `views/business/order/`，替换字段、接口和权限标识。

常用结构：

~~~vue
<template>
  <div class="index">
    <page-header>
      订单管理
      <template #subtitle>查询和维护订单信息</template>
      <template #action>
        <el-button @click="getPaginate">刷新</el-button>
      </template>
    </page-header>

    <div class="query-bar">
      <el-form :model="query" :inline="true" @submit.prevent="submitQuery">
        <el-form-item label="名称" prop="name">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item>
          <el-button native-type="submit" type="primary">查询</el-button>
          <el-button @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <el-table :data="orders" v-loading="paginateLoading">
      <el-table-column prop="name" label="名称" />
    </el-table>
  </div>
</template>
~~~

上述片段展示页面结构；`query`、`orders`、`paginateLoading` 及相关方法按列表模板实现。查询和重置时将 `page` 置为 `1`，再重新获取分页。查询按钮使用表单提交，支持回车；弹窗提交成功后刷新列表。

### 4. 配置访问入口

1. 在功能权限中添加查看、添加、修改、删除等标识及对应接口。
2. 在桌面路由中录入组件路径和布局。
3. 在桌面菜单中增加入口。
4. 在角色中分配权限、路由、菜单及需要的数据策略。
5. 重新登录以重新加载前端权限、菜单及路由。
6. 验证列表、详情、修改和删除的数据权限及错误响应。


## 桌面端组件

组件目录：[front/src/components](front/src/components)。Vite 已配置公共组件自动引入，根目录组件通常可直接写 `<page-header>`、`<dictionary-select>`，不必再手动导入。

嵌套目录启用了 `directoryAsNamespace`；名称不明确时可以显式导入对应文件，避免和同名业务组件混淆。以下参数名采用 JavaScript 写法，在模板中使用连字符形式，例如 `keyType` 对应 `key-type`。

### 页面与展示组件

| 组件 | 用途 | 主要参数、插槽 |
| --- | --- | --- |
| [PageHeader](front/src/components/PageHeader.vue) | 标题、说明和操作区；小屏时说明换行 | 默认插槽为标题，`subtitle` 为说明，`action` 为右侧操作 |
| [CardPanel](front/src/components/CardPanel.vue) | 带标题的内容卡片 | `title`、`subTitle`，默认内容和 `action` 插槽 |
| [FlagTitlePanel](front/src/components/FlagTitlePanel.vue) | 标记式标题内容区 | `title`、`subTitle`，默认内容和 `action` 插槽 |
| [NoHeaderCardPanel](front/src/components/NoHeaderCardPanel.vue) | 无标题卡片 | 默认内容插槽 |
| [AttributeList](front/src/components/AttributeList.vue) / [Attribute](front/src/components/Attribute.vue) | 详情页标签和值 | `Attribute` 的 `label`、`span`，默认插槽为值；`span` 默认 `8` |
| [FileView](front/src/components/FileView.vue) | 文件链接列表 | `files`，文件对象包含 `name` 和 `url` |
| [GenderIcon](front/src/components/GenderIcon.vue) | 性别图标 | `id`、`name` |
| [HorizontalLoading](front/src/components/HorizontalLoading.vue) | 横向加载提示 | `size`、默认插槽 |
| [Echart](front/src/components/Echart.vue) | ECharts 图表 | `option`；调用方设置宽高 |
| [Watermark](front/src/components/Watermark.vue) | 框架水印 | 由组件加载水印配置 |
| [PopupMessage](front/src/components/PopupMessage.vue) | 系统消息连接和提醒 | 框架内使用 |

详情展示示例：

~~~vue
<attribute-list>
  <attribute label="姓名">{{ user.name }}</attribute>
  <attribute label="账号">{{ user.account }}</attribute>
  <attribute label="单位">{{ user.department_name }}</attribute>
  <attribute label="说明" :span="24">{{ user.description }}</attribute>
</attribute-list>
~~~

### 字典与选择组件

| 组件 | v-model | 主要参数或事件 |
| --- | --- | --- |
| [DictionarySelect](front/src/components/DictionarySelect.vue) | 字典键，或键数组 | `type` 必填，`multiple`、`keyType`、`maxCollapseTags` |
| [DictionaryRadioGroup](front/src/components/DictionaryRadioGroup.vue) | 字典键 | `type`、`keyType`，`change` 事件 |
| [DictionaryCheckboxGroup](front/src/components/DictionaryCheckboxGroup.vue) | 字典键数组 | `type`、`keyType` |
| [TreeDepartmentSelect](front/src/components/TreeDepartmentSelect.vue) | 单位 ID 或数组 | `departmentId`、`multiple`、`placeholder`、`maxCollapseTags` |
| [RoleSelect](front/src/components/RoleSelect.vue) | 角色 ID 或数组 | `multiple` |
| [TreePermissionSelect](front/src/components/TreePermissionSelect.vue) | 权限 ID 或数组 | `permissionId`、`multiple`、`placeholder` |
| [DepartmentUsersSelect](front/src/components/DepartmentUsersSelect.vue) | 用户 ID 或数组 | `departmentId` 必填，`multiple`、`maxCollapseTags`，`change` 事件 |
| [UserSelect](front/src/components/UserSelect.vue) | 单个用户 ID | 封装单选用户弹窗 |
| [UsersSelect](front/src/components/UsersSelect.vue) | 用户 ID 数组 | 封装多选用户弹窗，显示已选数量 |
| [UserSelectDialog](front/src/components/UserSelectDialog.vue) | 单个用户 ID | `close`、`confirmed` 事件，确认时提供所选用户 |
| [UsersSelectDialog](front/src/components/UsersSelectDialog.vue) | 用户 ID 数组 | `close`、`confirmed` 事件，支持跨页选择 |
| [IconPicker](front/src/components/IconPicker.vue) | 图标英文名称 | 选择时同时展示图形和英文名称 |
| [department/TypeSelect](front/src/components/department/TypeSelect.vue) | 单位类型或数组 | `multiple` |
| [desktop/TreeMenuSelect](front/src/components/desktop/TreeMenuSelect.vue) | 菜单 ID 或数组 | `menuId`、`multiple`、`placeholder` |
| [desktop/route/LayoutSelect](front/src/components/desktop/route/LayoutSelect.vue) | 布局值或数组 | `multiple` |

常见调用：

~~~vue
<dictionary-select
  v-model="query.response_business_code"
  type="response_business_code"
/>
<tree-department-select v-model="user.department_id" />
<role-select v-model="user.role_ids" multiple />
<user-select v-model="form.user_id" />
<users-select v-model="form.user_ids" />
<icon-picker v-model="menu.icon" />
~~~

示例中的 `type` 必须与字典管理中的类型一致。字典组件 `keyType` 默认为 `"int"`，会把键转换成整数；非数字键可传 `key-type="string"`。数据回显时，`v-model` 中 ID 或键的类型要与选项一致。

用户和单位选择组件会调用相应组件接口，选择范围受后端数据权限约束。初始化授权时要配置 `global_user_access` 和 `global_department_access` 对应的策略。

### FileUpload 上传组件

[FileUpload.vue](front/src/components/FileUpload.vue) 封装 Element Plus Upload，统一接口前缀、token、业务错误提示和上传进度。

| 参数 | 作用 |
| --- | --- |
| `v-model` | Element Plus 文件列表 |
| `action` | 相对上传接口；默认 `desktop/FileUpload/upload`，自动增加 `VITE_API_PREFIX` |
| `name` | 上传字段名，默认 `file` |
| `data` | 附加表单数据，例如 `{ module: 'rich_editor' }` |
| `multiple` / `limit` | 多选和数量限制 |
| `accept` | 文件选择器类型提示 |
| `beforeUpload` | 上传前函数，返回 `false` 或拒绝 Promise 可阻止上传 |
| `showFileList` / `listType` | 文件列表显示方式 |
| `showPopoverProgress` | 是否显示进度弹层，默认 `true` |
| `disabled` / `drag` | 禁用和拖拽上传 |
| `withCredentials` / `crossorigin` | 透传上传组件的相关选项 |

事件包括 `success`、`remove`、`change`、`exceed`、`progress`、`error` 和 `abort`。成功事件参数为 `(response, uploadFile, uploadFiles)`。

插槽包括默认上传按钮、`tip`、`file` 和 `progress`。默认插槽提供 `uploading`；`progress` 提供 `files` 和 `abort`，可自定义进度显示。

~~~vue
<template>
  <file-upload
    v-model="files"
    :data="{ module: 'rich_editor' }"
    :before-upload="beforeUpload"
    @success="uploadSuccess"
  >
    <el-button type="primary">上传文件</el-button>
    <template #tip>示例：单个文件不超过 10 MB</template>
  </file-upload>
</template>

<script setup>
import { ref } from "vue";

const files = ref([]);

const beforeUpload = (file) => {
  if (file.size > 10 * 1024 * 1024) {
    ElMessage({ message: "文件不能超过 10 MB", type: "error" });
    return false;
  }
};

const uploadSuccess = (response) => {
  console.log(response.data.path);
};
</script>
~~~

`beforeUpload` 是函数属性，必须使用 `:before-upload`，不能通过 `@before-upload` 监听函数的返回值来阻止上传。

后端返回的文件信息包含 `name`、`type`、`ext`、`size`、`path` 和 `url`。桌面组件的 `v-model` 保留 Element Plus 文件对象，服务端数据位于 `file.response.data`：

~~~js
const uploadedFiles = files.value
  .filter((file) => file.status === "success" && file.response?.code == 0)
  .map((file) => file.response.data);
~~~

编辑页面回显的文件可能直接包含 `name`、`url` 等字段，需按实际保存结构与新上传结果统一后再提交。

当前桌面和移动上传控制器的模块白名单都只有 `rich_editor`。示例因此使用该值；新增业务模块需要扩展相应控制器白名单或提供专用上传接口。前端 `accept` 和大小检查用于交互提示，后端仍需执行验证。

### RichEditor 富文本组件

[RichEditor.vue](front/src/components/RichEditor.vue) 封装 wangEditor：

~~~vue
<rich-editor v-model="form.content" :height="400" />
~~~

| 参数 | 作用 |
| --- | --- |
| `v-model` | HTML 字符串 |
| `mode` | 编辑器模式，默认 `default` |
| `height` | 编辑区域高度，默认 `350` 像素 |
| `toolBarConfig` | 工具栏配置 |
| `editorConfig` | 编辑器配置 |

默认图片、视频上传使用 `desktop/FileUpload/upload`，自动附带 token 和 `module=rich_editor`。组件默认图片限制为 20 MB、视频为 200 MB；实际请求大小也受 PHP 和 Nginx 配置限制。

配置通过浅合并覆盖默认值。传入整个 `MENU_CONF` 会替换默认的 `MENU_CONF`，需要同时提供仍要保留的上传配置。只修改工具栏时使用 `tool-bar-config`。

### Echart 图表示例

~~~vue
<template>
  <echart :option="option" style="height: 320px" />
</template>

<script setup>
import { ref } from "vue";

const option = ref({
  xAxis: { type: "category", data: ["周一", "周二", "周三"] },
  yAxis: { type: "value" },
  series: [{ type: "line", data: [12, 20, 16] }],
});
</script>
~~~

组件负责初始化、监听配置和尺寸变化，以及卸载时销毁实例。容器必须有可用高度，否则图表不能正常显示。

## 移动端组件

目录：[front_mobile/src/components](front_mobile/src/components)。移动端也配置了组件自动引入，但组件属性和事件应以移动端实现为准。

| 组件 | 用途 | 主要接口 |
| --- | --- | --- |
| [CardPanel](front_mobile/src/components/CardPanel.vue) | 带标题卡片 | `title`、`subTitle`，默认内容和 `actions` 插槽 |
| [FlagTitlePanel](front_mobile/src/components/FlagTitlePanel.vue) | 标记式标题区域 | `title`、`subTitle`，默认内容和 `actions` 插槽 |
| [NoHeaderPanel](front_mobile/src/components/NoHeaderPanel.vue) | 无标题容器 | 默认插槽 |
| [NoHeaderPaddingPanel](front_mobile/src/components/NoHeaderPaddingPanel.vue) | 带内边距的无标题容器 | 默认插槽 |
| [LabelValue](front_mobile/src/components/LabelValue.vue) / [LabelValueItem](front_mobile/src/components/LabelValueItem.vue) | 标签和值的详情展示 | Item 的 `label` 和默认插槽 |
| [FileUpload](front_mobile/src/components/FileUpload.vue) | Vant 上传封装 | `v-model`、`module`、`multiple`、`maxCount` 等 |

移动卡片的操作插槽为 `actions`，桌面卡片为 `action`，复制页面时需要区分。

移动上传示例：

~~~vue
<file-upload
  v-model="form.files"
  module="rich_editor"
  multiple
  :max-count="5"
/>
~~~

- 默认请求 `mobile/FileUpload/upload`，自动携带 token。
- `module` 默认是 `module1`，当前后端不接受该模块值，使用时需要显式传入允许的值。
- 多选返回数组时逐个上传，整批结束后同步成功文件列表。
- 上传成功后把服务端元数据合入文件对象，`v-model` 输出含 `path` 的文件。
- `success` 事件接收上传成功的文件对象；默认插槽和 `tip` 插槽可自定义界面。
- `name` 默认 `file`，还支持 `accept`、`disabled`、`deletable` 和 `uploadIcon`。

## 前端工具与状态管理

### 桌面工具

| 文件 | 导出与用途 |
| --- | --- |
| [axios.js](front/src/helper/axios.js) | 默认导出请求实例，统一接口前缀、token、错误提示和登录失效 |
| [session.js](front/src/helper/session.js) | 具名导出 `login(token)` 和 `logout()` |
| [permission.js](front/src/helper/permission.js) | 具名导出 `hasPermission(keys)`，检查是否全部满足 |
| [stream_fetch.js](front/src/helper/stream_fetch.js) | 默认导出 `streamFetch`，提供 `get`、`post` 和取消能力 |
| [route_cache.js](front/src/helper/route_cache.js) | 动态路由的本地缓存，`get/set/clear` |
| [permission_cache.js](front/src/helper/permission_cache.js) | 功能权限的本地缓存，`get/set/clear` |
| [watermark_cache.js](front/src/helper/watermark_cache.js) | 水印配置的本地缓存，`get/set/clear` |

前端 `login(token)` 保存 token 后刷新进入系统，不负责验证账号密码。`logout()` 清理 token、权限和路由 Store，以及相关本地缓存，再跳转登录页；它本身不请求后端删除会话。主动退出时先调用后端退出接口，再清理前端登录状态，可参考 [Avatar.vue](front/src/layouts/main/Avatar.vue)。

### 流式请求

~~~js
import streamFetch from "@/helper/stream_fetch";

const task = streamFetch.post(
  "desktop/stream_fetch.Index/fetch",
  {},
  {
    onMessage(message) {
      console.log(message);
    },
    onComplete() {
      console.log("接收完成");
    },
    onError(error) {
      ElMessage({ message: error.message, type: "error" });
    },
  },
);

// 用户取消或页面卸载时调用：
// task.abort();
~~~

示例使用项目现有的演示接口，接入业务时替换为实际提供 `text/event-stream` 的接口。完整页面可参考 [流式页面](front/src/views/stream_fetch/Index.vue)。

工具支持：

- `get(path, options)`、`post(path, data, options)`。
- `options.params` 查询参数和 `options.headers` 自定义请求头。
- `onMessage`、`onComplete`、`onError` 回调，其中 `onMessage` 必填。
- LF 与 CRLF 空行分隔。
- 普通 JSON 响应、登录失效及非流响应的识别。
- 返回 `{ abort() }`，供页面取消请求。

返回值不是 Promise。开始请求后的异步错误通过 `onError` 处理，不能依赖外层 `await/catch` 捕获。`onMessage` 收到的是包含 `data:` 等内容的消息文本块，需要由业务解析。

### Pinia 状态

| Store | 作用 |
| --- | --- |
| [route.js](front/src/stores/route.js) | 动态路由数据和是否已设置标识 |
| [permission.js](front/src/stores/permission.js) | 当前用户功能权限标识 |
| [quick_navigation.js](front/src/stores/quick_navigation.js) | 已访问页面的快捷导航 |
| [theme.js](front/src/stores/theme.js) | 主题相关状态 |
| [theme_setting_form.js](front/src/stores/theme_setting_form.js) | 主题设置表单状态 |
| [layout/sidebar.js](front/src/stores/layout/sidebar.js) | 侧边栏状态，`useSidebarStore` |

### 移动工具

| 文件 | 用途 |
| --- | --- |
| [axios.js](front_mobile/src/helper/axios.js) | 移动端请求封装 |
| [Permission.js](front_mobile/src/helper/Permission.js) | `hasPermission`；文件名首字母为大写 |
| [array_handler.js](front_mobile/src/helper/array_handler.js) | 数组判断等辅助方法，目前包含 `isEmpty` |
| [WebsocketClient.js](front_mobile/src/helper/WebsocketClient.js) | WebSocket 客户端类，提供连接、重连、心跳及事件回调 |

移动 WebSocket 客户端是可复用工具，不能仅因文件存在就认为所有移动页面已接入消息服务。接入时仍需处理连接认证和页面生命周期。

## 后端助手类

目录：[back/app/helper](back/app/helper)。以下按照业务职责列出当前助手，便于新增模块时查找已有能力。具体参数、返回值和异常以对应源码为准。

### 认证、配置和基础助手

| 助手 | 主要用途和方法 |
| --- | --- |
| [ResponseHelper](back/app/helper/ResponseHelper.php) | `getSuccessResponse()`、`getErrorResponse()`，构造统一 JSON 响应 |
| [SessionHelper](back/app/helper/SessionHelper.php) | 会话添加、登录、认证、查询、删除和续期 |
| [JwtHelper](back/app/helper/JwtHelper.php) | `generateToken()`、`resolverToken()`，生成和解析 JWT |
| [LoginCountCheckerHelper](back/app/helper/LoginCountCheckerHelper.php) | `check()`、`setFail()`、`resetFail()` 等，限制连续登录失败 |
| [IpAuthHelper](back/app/helper/IpAuthHelper.php) | `ipAuth()`，执行 IP 访问检查 |
| [ConfigHelper](back/app/helper/ConfigHelper.php) | `getValue()`、`setValue()`、`getDeniedIps()`、`clearCache()` |
| [DictionaryHelper](back/app/helper/DictionaryHelper.php) | 字典增删改、键值查询和统一缓存清理 |
| [RuntimeHelper](back/app/helper/RuntimeHelper.php) | `getValue(key)`、`setValue(key, value)`，读写 `runtime` 表中的运行值 |
| [SiteHelper](back/app/helper/SiteHelper.php) | `getUrl()`、`getFullPath()`，处理站点相对路径 |
| [WatermarkHelper](back/app/helper/WatermarkHelper.php) | `getWatermark(userId)`，生成当前用户的水印信息 |

`ConfigHelper` 使用 `config` 表中 ID 为 `1` 的记录。`RuntimeHelper` 是运行值存储工具，应用版本来自 `VERSION` 文件，两者用途不同。

### SessionHelper 常用接口

~~~php
add(array $data)
login($terminal, $account, $password, $ip, $expireTime)
tokenAuth(int $terminal, $token)
apiAuth($userId, string $api)
getToken($id)
getUserId($id)
delete($id)
deleteByUserId($userId, $terminal = null)
deleteExpired()
renewExpireTime($id, int $expireTime, bool $limitInterval = false)
~~~

- `add()`、`login()` 返回会话 ID，`tokenAuth()` 认证通过后也返回会话 ID。
- `add()` 的数据中包含 `user_id`、`terminal`、`token` 和 `expire_time`；名称最长 63 字符。
- 名称留空时，按终端写入“桌面端登录”“移动端登录”或“API接口调用”等默认名称。
- `expireTime` 为 Unix 秒级时间戳。
- `deleteByUserId()` 不传终端时删除该用户全部会话，传终端时只删除对应端。
- `renewExpireTime()` 默认立即保存；最后一个参数传 `true` 时，新过期时间减去旧过期时间不足 3 分钟便跳过写入，用于自动续期。

手动设置新过期时间：

~~~php
$sessionHelper = new SessionHelper();
$sessionHelper->renewExpireTime($sessionId, $newExpireTime);
~~~

自动续期：

~~~php
$sessionHelper->renewExpireTime($sessionId, time() + 30 * 60, true);
~~~

### 用户助手

| 助手 | 主要用途 |
| --- | --- |
| [UserHelper](back/app/helper/UserHelper.php) | 添加、修改用户，按名称查 ID，获取名称和基础信息 |
| [user/UserPasswordHelper](back/app/helper/user/UserPasswordHelper.php) | 校验和修改密码 |
| [user/UserAvatarHelper](back/app/helper/user/UserAvatarHelper.php) | 头像地址、内容和头像修改 |
| [user/UserStatusHelper](back/app/helper/user/UserStatusHelper.php) | 修改用户状态 |
| [user/UserRoleHelper](back/app/helper/user/UserRoleHelper.php) | 获取用户角色 ID |
| [user/UserDepartmentHelper](back/app/helper/user/UserDepartmentHelper.php) | 获取用户单位 ID 和基础信息 |
| [user/UserPermissionHelper](back/app/helper/user/UserPermissionHelper.php) | 获取接口、权限标识，检查接口和功能权限 |
| [user/UserDesktopMenuHelper](back/app/helper/user/UserDesktopMenuHelper.php) | 获取用户可用菜单树 |
| [user/UserDesktopRouteHelper](back/app/helper/user/UserDesktopRouteHelper.php) | 获取用户可用路由 |
| [user/UserDataScopeHelper](back/app/helper/user/UserDataScopeHelper.php) | 获取数据访问规则、构建查询约束、检查记录范围、清理数据权限缓存 |
| [受数据权限约束的 TreeDepartmentHelper](back/app/helper/user/data_scope/global_department_access/TreeDepartmentHelper.php) | 按当前用户的单位访问权限返回单位树 |

### 单位助手

| 助手 | 主要用途 |
| --- | --- |
| [DepartmentHelper](back/app/helper/DepartmentHelper.php) | 单位 ID、名称、基础信息及是否存在单位或用户的判断 |
| [department/DepartmentPathHelper](back/app/helper/department/DepartmentPathHelper.php) | `getPath()`、`updatePath()`，维护单位层级路径 |
| [department/TreeDepartmentHelper](back/app/helper/department/TreeDepartmentHelper.php) | 按路径获取上下级 ID 和单位树 |
| [department/RecursiveTreeDepartmentHelper](back/app/helper/department/RecursiveTreeDepartmentHelper.php) | 递归获取上下级及路径 |
| [department/DepartmentUserHelper](back/app/helper/department/DepartmentUserHelper.php) | 获取单位用户、判断单位下是否有用户 |

处理单位及下级时，路径匹配需按完整层级边界，例如“路径等于 `/1/2`，或以 `/1/2/` 开头”，避免把 `/1/20` 误认为下级。新增查询优先复用已有助手。

### 角色和关联助手

| 助手 | 主要方法 |
| --- | --- |
| [RoleHelper](back/app/helper/RoleHelper.php) | `add(data)`、`edit(id, data)`、`delete(id)` |
| [role/RolePermissionHelper](back/app/helper/role/RolePermissionHelper.php) | `updateRelateByPermissionIds()`、`deleteByRoleId()`、`deleteByPermissionId()` |
| [role/RoleDesktopMenuHelper](back/app/helper/role/RoleDesktopMenuHelper.php) | `updateRelateByMenuIds()`、`deleteByRoleId()` |
| [role/RoleDesktopRouteHelper](back/app/helper/role/RoleDesktopRouteHelper.php) | `updateRelateByRouteIds()`、`deleteByRoleId()` |
| [role/RolePolicyHelper](back/app/helper/role/RolePolicyHelper.php) | `add()`、`updateRelateByPolicyIds()`、`deleteByRoleId()`、`deleteByPolicyId()` |
| [role/RoleUserHelper](back/app/helper/role/RoleUserHelper.php) | `deleteByRoleId()`，删除 `user_role` 中该角色的用户关系 |

角色添加和修改使用 `permission_ids`、`policy_ids`、`desktop_menu_ids`、`desktop_route_ids` 数组表达授权。前端不需要提交嵌套的数据权限对象来绑定策略。

### 功能权限、数据权限和桌面配置助手

| 助手 | 主要方法 |
| --- | --- |
| [PermissionHelper](back/app/helper/PermissionHelper.php) | `add()`、`edit(data)`、`delete()`、`getAllPermissionIds()`、`getTreePermission()`、`hasChildrenPermissions()` |
| [DataScopeHelper](back/app/helper/DataScopeHelper.php) | `add(data)`、`edit(id, data)`、`delete(id)`、`getDataScopes()`、`getPolicyIds(id)` |
| [data_scope/PolicyHelper](back/app/helper/data_scope/PolicyHelper.php) | `add(data)`、`edit(id, data)`、`delete(id)` |
| [data_scope/PolicyDepartmentHelper](back/app/helper/data_scope/PolicyDepartmentHelper.php) | `add(data)`、`deleteByPolicyId(id)` |
| [desktop/MenuHelper](back/app/helper/desktop/MenuHelper.php) | 获取菜单树和菜单 ID，判断是否有子菜单，删除菜单 |
| [desktop/RouteHelper](back/app/helper/desktop/RouteHelper.php) | `getRoutes()`，获取路由配置 |

`DataScopeHelper::getDataScopes()` 返回所有数据权限及其策略，不依赖角色；角色绑定关系由 `RolePolicyHelper` 处理。注意 `PermissionHelper::edit()` 当前接收一个数据数组，与部分助手的 `edit(id, data)` 签名不同。

### 字典调用示例

~~~php
use app\helper\DictionaryHelper;

$dictionaryHelper = new DictionaryHelper();
$list = $dictionaryHelper->getList('response_business_code');
$name = $dictionaryHelper->getValue('response_business_code', 0);
$names = $dictionaryHelper->getValuesString('response_business_code', [0, 1]);
~~~

`getList()` 返回 `key/value` 列表，`getValue()` 返回某一键对应的值，`getValuesString()` 把多个值按分隔符拼接，`getKey()` 按值反查键。通过助手添加、修改或删除字典时，会清理统一的 `dictionary` 缓存 tag。

### 日志、消息和示例业务助手

| 助手 | 主要用途 |
| --- | --- |
| [OperationLogHelper](back/app/helper/OperationLogHelper.php) | `add(data)` 写操作日志；`deleteByTimeRange(start, end)` 按时间段删除 |
| [MessageHelper](back/app/helper/MessageHelper.php) | 发送消息、队列发送、获取未读数、设置已读和通知已读 |
| [WebsocketMessageHelper](back/app/helper/WebsocketMessageHelper.php) | `send(userIds, data)` 向消息服务发送数据 |
| [order/TrendStatisticHelper](back/app/helper/order/TrendStatisticHelper.php) | `getTimeRangeTrend()`，生成趋势演示数据 |
| [order/ExcelHelper](back/app/helper/order/ExcelHelper.php) | `createTimeRangeTrendExcel()`，趋势 Excel 导出演示 |


## 消息与队列

### 消息处理流程

~~~text
业务代码
  → MessageHelper::sendsByQueue()
  → Redis DB 1 中的 message 队列
  → 队列 Worker 执行 app/job/Message.php
  → MessageHelper 写入 message 表
  → WebsocketMessageHelper 发送给消息服务
  → Workerman 转发给已绑定的用户连接
  → 桌面 PopupMessage 显示提醒并更新消息状态
~~~

`MessageHelper::send()`、`sends()` 是同步执行；`sendsByQueue()` 将发送任务入队，每个接收用户单独创建任务，避免一名用户失败导致整批重试。

默认队列连接由 `config/queue.php` 的 `default=redis` 决定。系统消息使用名为 `message` 的队列，因此 Worker 需要传入 `--queue=message`；Redis DB 编号由 `REDIS_DB_QUEUE` 决定，与队列名称分别配置。

### 调用示例

~~~php
use app\helper\MessageHelper;

$messageHelper = new MessageHelper();

// 同步发送给一个用户
$messageHelper->send($userId, '待办提醒', '你有一条新的待办', '/business/todo');

// 通过队列发送给多个用户
$messageHelper->sendsByQueue(
    $userIds,
    '待办提醒',
    '请及时处理',
    '/business/todo'
);
~~~

其他常用方法：

| 方法 | 作用 |
| --- | --- |
| `getNoReadCount(userId)` | 查询未读数量 |
| `setRead(userId, id)` | 在数据库标记一条消息已读 |
| `setAllRead(userId)` | 在数据库标记用户的全部消息已读 |
| `sendRead(userId, id)` | 向在线端发送单条已读通知 |
| `sendAllRead(userId)` | 向在线端发送全部已读通知 |
| `sendReadByQueue()` / `sendAllReadByQueue()` | 通过队列发送已读通知 |

修改数据库已读状态和通知在线连接是两项操作，调用时根据业务需要配合使用。

### 运行与失败处理

本地运行：

~~~sh
php think message
php think queue:work --queue=message --tries=3 --delay=30
~~~

队列任务成功后删除；失败异常交给队列 Worker，按上述命令最多尝试 3 次，重试间隔为 30 秒。最终失败原因通过 `message_error` 级别写入独立日志文件。

Linux 可使用：

~~~sh
php think message start --daemon true
php think message status
php think message stop
~~~

Docker 内 [supervisord.conf](back/docker/supervisord.conf) 已管理 Nginx、PHP-FPM、消息服务和消息队列进程，无需在同一容器内重复启动这些进程。

修改缓存或队列配置后，需要重启已有消息服务和队列 Worker。旧 `jobs` 表中的待处理任务不会自动迁移到 Redis；数据库队列连接仍保留，需要处理旧任务时可以显式指定 `database` 连接。

### 连接与发送认证

桌面浏览器连接 WebSocket 后用当前 token 绑定身份。后端发送助手使用发送协议的 `key` 校验，不需要先按浏览器方式绑定用户。

当前消息连接主要面向桌面端，绑定时使用桌面终端认证。跨终端接入时需要同步调整服务端认证及客户端配置，不能直接把 API 会话当作桌面连接凭据。

## 操作日志

操作日志由 [OperationLog 中间件](back/app/middleware/OperationLog.php) 统一记录，三端分别在应用中间件配置中传入终端值。

### 记录内容

| 类别 | 字段或内容 |
| --- | --- |
| 身份信息 | `session_id`、`user_id`、`department_id`、`terminal` |
| 请求信息 | `api`、`request_method`、`request_content`、IP、操作时间 |
| 响应信息 | `response_http_code`、`response_business_code`、`response_content` |
| 性能信息 | `duration`，整数毫秒 |

`request_content` 由以下结构编码成 JSON：

~~~json
{
  "header": {
    "content-type": "application/json"
  },
  "files": {},
  "body": {
    "id": 1
  }
}
~~~

- `header` 来自当前请求头，`body` 来自 `$request->param(false)` 参数集合。
- 当前实现不做敏感字段过滤，也不保证保留原始请求体的字节、空格和字段顺序。
- 上传文件记录名称、大小、接收时临时路径、类型和扩展名，不把文件二进制写入数据库。
- 临时路径表示请求接收时的位置，不等同于上传成功后的持久化路径。
- 普通响应记录 `getContent()` 的结果，下载文件响应记录文件路径。
- 前端详情弹窗会把可解析的 JSON 格式化显示。

### 错误处理与查询

中间件在请求采集或操作日志入库失败时，通过 `operation_log_error` 写入独立文件，继续返回业务响应。

[config/log.php](back/config/log.php) 通过 `apart_level` 为 `operation_log_error` 和 `message_error` 分文件记录。默认运行日志位于 `back/runtime` 下。

操作日志页面分别显示 HTTP 状态码和业务码。业务码通过 `response_business_code` 字典展示，成功为绿色，其余为红色，并可按业务码筛选。

### 按时间段删除

操作日志页面提供起止时间及 3 个月前、6 个月前、1 年前、2 年前、3 年前、5 年前的快捷时间设置。

对应接口对象为 `TimeRangeDelete`，验证器位于操作日志命名空间，助手方法为：

~~~php
$operationLogHelper->deleteByTimeRange($startTime, $endTime);
~~~

时间为秒级时间戳，包含起止边界。当前方法调用查询构造器的批量 `delete()`，返回影响行数；与单个模型实例 `delete()` 的布尔返回值不同。

## 缓存管理

后端默认通过 Redis 存储缓存，原有 `Cache` 和 tag 调用方式不变，缓存键前缀为 `sun_admin:`。文件缓存连接保留在配置中，默认不使用。

Redis 缓存驱动的默认有效期为 `0`，表示不自动过期；各助手在写入时指定的 TTL 仍按原值生效。切换后缓存会在首次访问时重新生成，旧文件缓存无需迁移。

### 当前缓存范围

| 缓存 | 位置 | 时效与失效方式 |
| --- | --- | --- |
| 系统设置 | 后端，`config` tag | 7 天，通过 ConfigHelper 更新时清理 |
| 字典 | 后端，`dictionary` tag | 7 小时，通过 DictionaryHelper 增删改时清理 |
| 用户数据权限结果 | 后端，`data_scope` tag | 600 秒，可调用 `UserDataScopeHelper::clearCache()` |
| 会话用户 ID、用户单位等 | 后端助手内部 | 按各助手实现的 TTL |
| 路由、功能权限 | 浏览器 localStorage | 30 分钟，退出时清理 |
| 水印信息 | 浏览器 localStorage | 12 小时，退出时清理 |

缓存标签用于统一清理，读取时按缓存键获取即可，不需要再次指定 tag。

### 清理方法

清理对应领域：

~~~php
(new ConfigHelper())->clearCache();
(new DictionaryHelper())->clearCache();
(new UserDataScopeHelper())->clearCache();
~~~

清理当前后端 Redis 缓存库：

~~~php
\think\facade\Cache::clear();
~~~

该方法清空 `REDIS_DB_CACHE` 指定的整个 Redis DB，因此该 DB 应专用于本站缓存。队列使用独立的 `REDIS_DB_QUEUE`，不会被一并清除。`php think clear --cache` 只清理运行目录中的缓存文件，不能清理 Redis。上述操作均不会清理浏览器缓存。

菜单、路由、权限调整后，退出并重新登录可重新获取前端数据。

角色、策略或单位关系变更不应被假定为自动清除了所有缓存。需要立即生效时，应在对应变更流程调用已有清理入口；否则受相应缓存 TTL 影响。

## 主题与布局

### 路由布局

| 布局 | 文件 | 用途 |
| --- | --- | --- |
| `main` | [layouts/Main.vue](front/src/layouts/Main.vue) | 挂载主界面和业务页面 |
| `blank` | [layouts/Blank.vue](front/src/layouts/Blank.vue) | 使用空白容器展示页面 |
| 侧边栏形式 | [main/Sidebar.vue](front/src/layouts/main/Sidebar.vue) | 主布局的一种导航形式 |
| 顶部导航形式 | [main/TopNavigation.vue](front/src/layouts/main/TopNavigation.vue) | 主布局的另一种导航形式 |

`Sidebar.vue` 和 `TopNavigation.vue` 属于同一个 main 路由布局的两种呈现方式。桌面路由的 `layout` 仍填写 `main` 或 `blank`。

### 样式配置位置

| 文件或目录 | 用途 |
| --- | --- |
| [assets/app.scss](front/src/assets/app.scss) | 公共页面和组件样式 |
| [assets/light.scss](front/src/assets/light.scss) | 明亮主题业务变量 |
| [assets/dark.scss](front/src/assets/dark.scss) | 暗色主题业务变量 |
| [assets/element_plus/light](front/src/assets/element_plus/light) | Element Plus 明亮主题 SCSS 和 CSS 变量 |
| [assets/element_plus/dark](front/src/assets/element_plus/dark) | Element Plus 暗色主题 SCSS 和 CSS 变量 |

修改主题时同时检查明暗两套，避免单独改亮色导致暗色样式失配。

### 背景变量约定

| 变量 | 语义 |
| --- | --- |
| `--background-color-body` | 整个网页的底色，包括布局外的页面 |
| `--background-color-page` | 主要页面、dialog 等视窗内容区域 |
| `--background-color-panel` | 面板、欢迎区域、统计卡片等独立内容块 |
| `--background-color-layout-main-header` | 主布局头部 |
| `--background-color-table-header` | 表格表头 |
| `--background-color` / `--background-color-light` / `--background-color-dark` | 内容内部需要区分时使用的通用背景层级 |

相同颜色值可以代表不同语义。例如 page 和 panel 在亮色主题下都可以是白色，后续仍能分别调整。表头背景由公共样式统一控制，业务列表无需重复写表头颜色。

文字按 `--font-color`、`--font-color-secondary`、`--font-color-tertiary` 表示层级。Element Plus 控件的文字、填充等优先使用对应 `--el-*` 变量，避免把控件填充固定成页面背景色。

## 自动化测试

### 当前测试范围

后端采用 [phpunit.xml](back/phpunit.xml) 和 [tests/bootstrap.php](back/tests/bootstrap.php) 初始化真实 ThinkPHP 应用。

| 测试 | 当前检查内容 |
| --- | --- |
| [UserTest](back/tests/unit/UserTest.php) | 调用真实 `UserHelper::getName(1)`，检查是否成功执行 |
| [UserDataScopeTest](back/tests/unit/user/UserDataScopeTest.php) | 调用真实 `canAccessUser(1, 'global_user_access', 1)`，检查访问是否允许 |
| [Test](back/tests/unit/Test.php) | 基础断言演示 |

这些测试使用环境文件中的真实 MySQL 和 Redis 连接，不会自动创建隔离数据库，也不使用 Mock 替代助手。运行前需要两个服务均可访问，并有对应用户和授权数据；数据权限测试会通过真实助手读写 Redis 缓存。

当前测试属于基础回归检查，没有覆盖全部策略组合和系统功能。两个前端目前没有配置自动测试脚本。

### 运行命令

~~~sh
cd back
composer install

# 全部测试
php vendor/phpunit/phpunit/phpunit

# 指定测试类
php vendor/phpunit/phpunit/phpunit --filter UserTest
php vendor/phpunit/phpunit/phpunit --filter UserDataScopeTest

# 指定测试套件
php vendor/phpunit/phpunit/phpunit --testsuite unit

# 生成 GitLab 可展示的 JUnit 报告
php vendor/phpunit/phpunit/phpunit --log-junit tests/report.xml
~~~

项目中的 `php think test` 是自定义调试命令，不是上述 PHPUnit 测试入口。

### 新增测试

在 `back/tests/unit/` 或其子目录中增加 `XxxTest.php`，继承 `PHPUnit\Framework\TestCase`，方法名使用 `test` 开头：

~~~php
<?php

namespace unit;

use app\helper\user\UserDataScopeHelper;
use PHPUnit\Framework\TestCase;

class AccessTest extends TestCase
{
    public function testUserCanAccessOwnRecord(): void
    {
        $helper = new UserDataScopeHelper();

        $this->assertTrue(
            $helper->canAccessUser(1, 'global_user_access', 1)
        );
    }
}
~~~

示例依赖 ID 为 `1` 的用户具有相应策略。测试数据需要与断言的业务前提一致。

`phpunit.xml` 已扫描 `tests/unit`，符合命名规则的新文件不需要逐个加入配置。

### 失败与退出码

当前 `stopOnFailure="false"` 表示一次运行中某个测试失败后继续执行其他测试。全部运行结束后，只要有失败，PHPUnit 仍会返回非零退出码。

GitLab CI 根据命令退出码判断作业成功或失败。JUnit 报告用于界面展示测试明细，不负责决定是否进入后续构建阶段。

## 构建与部署

### 前端静态构建

桌面端和移动端分别运行：

~~~sh
cd front
npm ci
npm run build
~~~

~~~sh
cd front_mobile
npm ci
npm run build
~~~

正式环境变量见各自的 `.env.production`，默认产物目录为 `dist`。`npm run preview` 用于本地预览构建产物，不作为正式服务部署方案。

桌面端使用 history 路由，静态服务器需要将页面路径回退到 `index.html`。仓库 [桌面 Nginx 配置](front/docker/nginx.conf) 已包含相应处理。

### 构建 Docker 镜像

在仓库根目录执行，以下 `1.4.5` 仅为示例版本：

~~~sh
docker build --build-arg VERSION=1.4.5 -t sun_admin_back:1.4.5 back
docker build -t sun_admin_front:1.4.5 front
docker build -t sun_admin_front_mobile:1.4.5 front_mobile
~~~

后端镜像使用 `back/docker/.env`。构建前应准备对应环境；上传文件和数据库数据使用持久化目录，容器替换后继续使用原数据。

### Docker Compose

部署示例位于 [资料/部署/docker-compose.yml](资料/部署/docker-compose.yml)，当前包含 `back`、`front` 和 `mysql`，移动端需要按实际部署另外增加服务。

首次使用先调整：

1. 三个服务的镜像或构建配置，示例镜像版本当前为 `1.4.3`。
2. 数据库连接信息及后端 `back/docker/.env` 中的 Redis 地址、密码；容器使用宿主机 Redis 时，Redis 需监听容器可访问的地址。
3. 数据库、上传文件的宿主机持久化目录；示例包含 Linux 绝对路径。
4. 前端映射端口、部署地址及 WebSocket 地址。
5. 后端构建参数 `VERSION`；只修改镜像标签不会改变界面显示的版本。

配置中的 `build.context` 使用仓库根目录下的 `./back/`、`./front/`，从根目录运行时指定 project-directory：

~~~sh
docker compose --project-directory . -f "资料/部署/docker-compose.yml" up -d --build
~~~

首次启动后还需要向数据库导入初始化 SQL。该 Compose 示例没有自动完成数据库初始化和所有部署参数配置。

### 反向代理和真实 IP

当前部署链路为：

~~~text
浏览器 → 宿主机 Nginx → 前端 Nginx 容器 → 后端容器
~~~

前端 Nginx 将 `/api/` 转发到后端，把 `/websocket-message` 转发到消息服务。浏览器的 WebSocket URL 应指向能到达该代理入口的地址。

真实 IP 配置位于：

- [back/app/Request.php](back/app/Request.php)：信任代理网段及 `HTTP_X_REAL_IP`。
- [front/docker/nginx.conf](front/docker/nginx.conf)：处理宿主机传入的真实 IP 并转发。
- [docker-compose.yml](资料/部署/docker-compose.yml)：容器网络示例为 `172.30.0.0/24`，网关为 `172.30.0.1`。

宿主机 Nginx 需要设置：

~~~nginx
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
~~~

更改 Compose 网络或代理链时，需要同步调整可信代理配置。不能只转发请求头而忽略应用的可信代理设置，否则操作日志和 IP 访问控制读取到的可能仍是代理地址。

### 运行与更新

- `back/runtime` 和上传目录需要 PHP 运行用户可写。
- 生产环境使用 `APP_DEBUG=false`。
- 后端容器由 Supervisor 启动消息和队列进程。
- 更新业务代码时同步检查 SQL、环境变量、菜单、路由和权限基础数据。
- 使用版本对应的增量 SQL 更新已有数据库，再替换镜像并验证登录、分页和主要业务操作。

仓库目前没有自动数据库迁移流程。`资料/部署/3.8.2/` 中的升级 SQL 和说明文件当前为空，不能作为完整升级脚本使用。

## GitLab CI 与版本号

配置文件：[.gitlab-ci.yml](.gitlab-ci.yml)。

### 什么情况下创建流水线

| 触发条件 | 是否创建 | VERSION |
| --- | --- | --- |
| 推送 Git tag | 是 | `CI_COMMIT_TAG` |
| `product` 分支提交更新 | 是 | `CI_COMMIT_SHORT_SHA` |
| 手动选择 tag 新建流水线 | 是 | 所选 tag |
| 手动选择 `product` 分支新建流水线 | 是 | 该提交的短 SHA |
| 其他分支 | 否 | 被 workflow 规则排除 |

这是当前配置的实际规则：tag 和 product 分支是两个独立入口，并没有额外验证 tag 指向的提交必须属于 product。

选择 tag 构建时，使用该 tag 指向的提交；选择 product 时，使用选定的 product 提交。

### 流水线阶段

~~~text
test → build → package → push
~~~

| 阶段 | 当前行为 |
| --- | --- |
| `test` | 用 PHP 8.2 容器安装 Composer 开发依赖，执行 PHPUnit，上传 JUnit 报告 |
| `build` | 分别构建后端、桌面端和移动端镜像 |
| `package` | 使用 `docker save` 导出三个 `.tar` 文件，产物保存 1 周 |
| `push` | 登录 Harbor，推送三个镜像，再退出登录 |

当前流水线没有自动登录服务器或更新运行容器的部署作业。

测试作业的 `artifacts.reports.junit` 用来向 GitLab 展示测试用例结果；打包作业的 `artifacts.paths` 用来保存可下载的镜像文件。报告不代替测试命令退出码。

### Runner 和数据库要求

当前作业使用标签 `runner22`，Runner 必须能执行 Docker。多个阶段通过本机镜像名传递构建结果，因此需要共享同一 Docker 守护进程和镜像存储，或按运行环境自行调整交付方式。

测试容器：

- 挂载仓库 `back` 目录。
- 将 `back/docker/.env_test` 挂载为容器内的 `.env`。
- 使用 `--network host` 访问已配置的数据库。
- 不自动启动 MySQL 或 Redis service，需要在环境文件中填写 Runner 能访问的数据库、Redis 地址及密码。

仅填写开发电脑的 `127.0.0.1` 不代表远程 Runner 能访问开发电脑数据库，应按 Runner 的实际网络位置填写地址。

### Harbor 变量

在 GitLab CI/CD Variables 中配置：

| 变量 | 含义 |
| --- | --- |
| `HARBOR_REGISTRY` | Harbor 地址 |
| `HARBOR_USERNAME` | 镜像仓库登录用户 |
| `HARBOR_PASSWORD` | 镜像仓库登录密码 |
| `HARBOR_PROJECT` | Harbor 项目名，默认 `sun_admin` |

### 界面版本号的来源

~~~text
Git tag（有值时）或提交短 SHA
  → GitLab CI 的 VERSION
  → docker build --build-arg VERSION
  → 后端镜像中的 /var/www/html/VERSION
  → config('app.version')
  → 前端获取后显示
~~~

后端 [Dockerfile](back/Dockerfile) 的 `VERSION` 构建参数默认是 `dev`。[config/app.php](back/config/app.php) 读取项目根下的 `VERSION` 文件，文件不存在时返回 `0.0.0`。

桌面登录页、主布局和关于系统共用这一版本来源，不需要分别改前端版本。两个前端 `package.json` 中的 `0.0.0` 不是当前发布版本来源。

## 开发约定

### 命名与目录

| 对象 | 约定 |
| --- | --- |
| PHP 类、Vue 组件 | 大驼峰，如 `SessionHelper`、`PageHeader.vue` |
| PHP 方法、JS 函数和变量 | 小驼峰，如 `renewExpireTime`、`paginateLoading` |
| 数据表、字段、权限标识 | 小写加下划线，如 `role_policy`、`user_id`、`session_delete` |
| JS 工具文件 | 使用现有小写/下划线风格，如 `stream_fetch.js`，普通前端工具不统一追加 Helper 后缀 |
| CSS 类 | 使用 BEM 风格，如 `page-header__title` |
| 后端公共类 | 使用 `Helper`、`Validate`、`Model` 后缀，方便自动导入并减少重名 |
| 控制器、队列和命令 | 按业务功能组织目录，遵循当前项目风格 |

仓库已有少数文件名采用其他大小写，引用时以实际文件名为准，尤其需要兼容 Linux 的大小写敏感路径。

### 页面和接口

- 统一使用“查询”和“重置”文案；查询表单支持回车提交并阻止原生跳转。
- 分页加载变量使用 `paginateLoading`。
- 页面标题、说明、操作区使用 `PageHeader`。
- 公共查询栏的普通输入框和选择框宽度按现有公共样式统一为 200 像素。
- 调用项目请求工具时填写相对接口路径，不重复拼接 `/api/`。
- 修改、删除等操作验证 ID 和业务字段；列表使用 `PaginationValidate`。
- 新模块需配置菜单、路由、功能权限和必要的数据策略。
- 跨资源关联由控制器组织，助手保持自身职责。
- 单条模型删除与查询构造器批量删除的返回值、模型事件行为不同，按业务需求选择。

## 常见问题

### 页面 404，但后端接口存在

检查桌面路由记录、角色的路由授权，以及 `component_path` 对应文件是否存在。菜单有入口不代表用户已经获得路由权限。修改后重新登录加载前端路由缓存。

### 有菜单，也有路由，但接口提示无权限

检查功能权限的 `apis_string` 是否包含后端实际收到的接口路径，并确认角色已绑定该权限。路径不包含前端代理前缀 `/api/`；不要把界面路由路径当作后端接口路径。

### 下拉框回显成 ID，没有显示名称

检查绑定值与选项值的类型是否一致，例如字符串 `"1"` 和数字 `1`；也要检查选项是否已加载，以及该用户是否有权获取选项。

### 上传提示“模块文件夹不支持上传”

当前公共上传白名单只有 `rich_editor`。桌面组件通过 `data.module` 传入，移动组件通过 `module` 属性传入；新业务需要同步扩展后端允许的模块。

### 上传成功，但提交表单时没有文件路径

桌面 `FileUpload` 的新上传结果在 `file.response.data`，需要提取后提交。移动组件会把服务端信息合入文件对象，两端的数据结构不同。

### 系统消息没有提醒

分别检查消息是否入队、队列 Worker 是否启动、消息服务是否启动，以及前端 WebSocket 地址和 token 绑定是否成功。只运行前端开发服务器不会启动后端消息进程。

### 修改权限后没有立刻更新

前端路由和权限有本地缓存，后端数据权限也有缓存。前端可退出重新登录，后端按需要调用对应助手的清理方法。仅刷新页面不一定清除缓存。

### PHPUnit 连接数据库失败

本地测试读取 `back/.env`；CI 读取 `back/docker/.env_test`。检查实际运行位置、数据库地址及授权，确认测试用到的用户和策略数据已经初始化。

### Redis 连接或认证失败

- 提示 Redis 扩展未安装时，运行 `php --ri redis` 检查实际使用的 PHP；命令行和 PHP-FPM 的配置可能不同。
- 提示 `NOAUTH` 或 `WRONGPASS` 时，检查当前环境文件中的 `REDIS_PASSWORD`，包含特殊字符的密码使用引号包裹。
- 提示连接被拒绝时，检查 Redis 服务、地址和端口。容器中的 `127.0.0.1` 指向容器自身，访问宿主机 Redis 使用已配置的 `host.docker.internal`。
- 修改配置后重启消息服务和队列 Worker，使常驻进程重新读取连接配置。

### 构建镜像后，界面版本没有变化

确认构建后端时传入了 `--build-arg VERSION=...`，并且运行的是新镜像。Docker 镜像的标签不会自动写入应用的 `VERSION` 文件。

### 刷新业务页面后，Nginx 返回 404

检查前端 history 路由回退配置，业务页面路径需要返回前端 `index.html`。同时确认 `VITE_BASE` 与部署目录一致。

### 低版本浏览器显示空白

当前前端使用 Vite 6 默认构建配置，没有接入 legacy 插件或统一的浏览器版本检测。不能仅调整 JS 目标版本就保证全部 CSS 和运行时 API 兼容。建议使用较新的 Chrome、Edge 等浏览器；如需支持指定旧版本，应针对实际浏览器版本验证构建、依赖和样式。
