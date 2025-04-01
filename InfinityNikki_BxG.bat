@REM 一共需要修改两个路径，如下：

@REM:: 修改1：这里设置已有游戏资源的游戏路径，我这里是B服
@Set FromDir=D:\GameApp\InfinityNikkiBili Launcher\InfinityNikkiBili
@REM:: 修改2：这里设置待转的游戏路径，我这里是国服
@Set ToDir=D:\GameApp\InfinityNikki Launcher\InfinityNikki

@REM:: 再C盘记得用管理员权限运行批处理，不放心的话可以先仔细看一下脚本到底做了什么 :D
@REM:: 如果没有HotUpdate，或者没有Database，那就直接安排链接

@REM:: 这个步骤目的是将Hotupdate的文件更新，建议先做一个重命名.bak备份比较合适：
@del /Q /S /F "%ToDir%\X6Game\Saved\HotUpdate\*"
@for %%F in ("%FromDir%\X6Game\Saved\HotUpdate\*") do @(
	@copy /Y "%%F" "%ToDir%\X6Game\Saved\HotUpdate\"
)

@REM:: 这个步骤我简单把save的非原生文件夹保留，合并后面新增的目录：
@for /f "tokens=*" %%B in ('dir /b /a:l "%ToDir%\X6Game\Saved\"') do @(
	@REM echo "%ToDir%\X6Game\Saved\%%B"
	@rmdir "%ToDir%\X6Game\Saved\%%B"
)
@for /d %%A in ("%FromDir%\X6Game\Saved\*") do @(
	@REM echo %%~nA
	@mklink /D /J "%ToDir%\X6Game\Saved\%%~nA" "%%A" 
)

@REM:: 这个步骤可以复用已有PaperBin文件，跳过着色器重复编译，已验证有效性，覆盖已有：
@copy /Y "%FromDir%\X6Game\Saved\PaperBin" "%ToDir%\X6Game\Saved\PaperBin"
@copy /Y "%FromDir%\X6Game\Saved\PSOVersion.ini" "%ToDir%\X6Game\Saved\PSOVersion.ini"

@REM:: 目前已知X6Game_PCD3D_SM5.upipelinecache这是类似一个本地索引文件，不应该去改动它！
@REM:: 否则相册可能会受影响！

@pause
