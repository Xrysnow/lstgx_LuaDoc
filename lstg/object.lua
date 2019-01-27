---
--- object.lua
---
--- Copyright (C) 2018-2019 Xrysnow. All rights reserved.
---


-- 对象控制函数


---获取对象池中对象个数。
---@return number
function GetnObj()
end

---更新对象池。此时将所有对象排序并归类。
---排序规则：uid越小越靠前
--- 细节
--->luaSTG+中该函数不再起任何作用，对象表总是保持有序的。
function UpdateObjList()
end

---更新对象列表中所有对象，并更新属性。
---禁止在协程上调用该方法。
--- 细节
--->按照下列顺序更新这些属性：
--->vx += ax
--->vy += ay
--->x += vx
--->y += vy
--->rot += omiga
--->更新绑定的粒子系统（若有）
function ObjFrame()
end

---渲染所有对象。此时将所有对象排序。
---禁止在协程上调用该方法。
---排序规则：layer小的先渲染，若layer相同则按照uid
--- 细节
---　 luaSTG+中渲染列表总是保持有序的，将不会每次排序。
function ObjRender()
end

---设置舞台边界
---@param left number
---@param right number
---@param bottom number
---@param top number
function SetBound(left, right, bottom, top)
end

---执行边界检查。注意BoundCheck只保证对象中心还在范围内，不进行碰撞盒检查
---禁止在协程上调用该方法
---将bound==true并且x,y在SetBound设置范围外的所有对象状态置为'del'
function BoundCheck()
end

---对组A和B进行碰撞检测。如果组A中对象与组B中对象发生碰撞，将执行A中对象的碰撞回调函数。
---禁止在协程上调用该方法。
---@param A number
---@param B number
function CollisionCheck(A, B)
end

---刷新对象的dx,dy,lastx,lasty,rot（若navi=true）值。
---禁止在协程上调用该方法。
function UpdateXY()
end

---刷新对象的timer和ani_timer，若对象被标记为del或kill将删除对象并回收资源。
---禁止在协程上调用该方法。
--- 细节
---　 对象只有在AfterFrame调用后才会被清理，在此之前可以通过设置对象的status字段取消删除标记。
function AfterFrame()
end

---创建新对象。将累加uid值。
---> 细节:该方法使用class创建一个对象，并在构造对象后调用class的构造方法(init)构造对象。
---　 被创建的对象具有如下属性：
--->x, y　　　　　　 坐标
--->dx, dy　　　　　 (只读)距离上一次更新的坐标增量
--->rot　　　　　　　角度
--->omiga　　　　　　角度增量
--->timer　　　　　　计数器
--->vx, vy　　　　　 速度
--->ax, ay　　　　　 加速度
--->layer　　　　　　渲染层级
--->group　　　　　　碰撞组
--->hide　　　　　　 是否隐藏
--->bound　　　　　　是否越界销毁
--->navi　　　　　　 是否自动更新朝向
--->colli　　　　　　是否允许碰撞
--->status　　　　　 对象状态，返回del kill normal
--->hscale, vscale　 横向、纵向的缩放
--->class　　　　　　对象的父类
--->a, b　　　　　　 碰撞盒大小
--->rect　　　　　　 是否为矩形碰撞盒
--->img　　　　　　　绑定的图像/动画资源(名称)
--->ani　　　　　　　(只读)动画计数器
---　 被创建对象的索引1和2被用于存放类和id【请勿修改】
---　 其中父类class需满足如下形式：
--->is_class = true
--->[1] = 初始化函数 (object, ...)
--->[2] = 删除函数(DEL) (object, ...)
--->[3] = 帧函数 (object)
--->[4] = 渲染函数 (object)
--->[5] = 碰撞函数 (object, object)
--->[6] = 消亡函数(KILL) (object, ...)
---　 上述回调函数将在对象触发相应事件时被调用
---　 luastg+提供了至多32768个空间共object使用。超过这个大小后将报错。
---@return object
function New(class, ...)
end

---通知删除一个对象。将设置标志并调用回调函数。
---若在object后传递多个参数，将被传递给回调函数。
---@param obj object
function Del(obj, ...)
end

---通知杀死一个对象。将设置标志并调用回调函数。
---若在object后传递多个参数，将被传递给回调函数。
---@param obj object
function Kill(obj, ...)
end

---IsValid(obj)
---检查对象是否有效
---对象为table，且具有正确的资源池id
---@return boolean
function IsValid(obj)
end

---设置速度方向和大小（C++对象）
---@param obj object @要设置的对象
---@param v number @速度大小
---@param angle number @速度方向（角度）
---@param updateRot boolean @是否更新自转，默认为false
function SetV(obj, v, angle, updateRot)
end

---获取速度方向和大小（C++对象）
---@param obj object
---@return number, number @速度大小，速度方向（角度）
function GetV(obj)
end

---设置资源状态
---该函数将会设置和对象绑定的精灵、动画资源的混合模式，该设置对所有同名资源都有效果
---@param object object
---@param blend string @混合模式
---@param a number
---@param r number
---@param g number
---@param b number @颜色
function SetImgState(object, blend, a, r, g, b)
end

---Angle(objA,objB)
---Angle(x1,y1,x2,y2)
---计算两点连线角度
---@return number
function Angle(objA, objB)
end

---计算两点距离
---@param objA object
---@param objB object
---@return number
function Dist(objA, objB)
end

---检查对象中心是否在所给范围内
---@param object object
---@param left number
---@param right number
---@param bottom number
---@param top number
---@return boolean
function BoxCheck(object, left, right, bottom, top)
end

---清空并回收所有对象
function ResetPool()
end

---在对象上调用默认渲染方法
---@param obj object
function DefaultRenderFunc(obj)
end

---获取组中的下一个元素。若groupid为无效的碰撞组则返回所有对象。
---返回的第一个参数为id（luastg中为idx），第二个参数为对象
--- 细节
---　 luastg中NextObject接受的第二个参数为组中的元素索引而非id。
---　 出于效率考虑，luastg+中接受id查询下一个元素并返回下一个元素的id。
---@param groupid number
---@param id number
---@return object
function NextObject(groupid, id)
end

---产生组遍历迭代器
--- 细节
---　 由于NextObject行为发生变更，ObjList只在for循环中使用时可以获得兼容性。
function ObjList(groupid)
end

---获取C++对象属性
---用于 enemybase laser_bent
---@param obj object
---@param key string
---@return any
function GetAttr(obj, key)
end

---设置属性，视情况设置C++对象的属性或lua对象的属性
---用于 boss enemybase laser_bent
---@param obj object
---@param key string
---@param v any
function SetAttr(obj, key, v)
end

---启动绑定在对象上的粒子发射器
---@param object object
function ParticleFire(object)
end

---停止绑定在对象上的粒子发射器
---@param object object
function ParticleStop(object)
end

---返回绑定在对象上的粒子发射器的存活粒子数
---@param object object
function ParticleGetn(object)
end

---获取绑定在对象上粒子发射器的发射密度（个/秒）
--- 细节
---　 luastg/luastg+更新粒子发射器的时钟始终为1/60s。
---@param object object
function ParticleGetEmission(object)
end

---设置绑定在对象上粒子发射器的发射密度（个/秒）
---@param object object
---@param count number
function ParticleSetEmission(object, count)
end

function RegisterClass(class)
end

function GetLastXY(object)
    return 0, 0
end

function SetLastXY(object, x, y)
end

function UpdateParticle(object)
end

function FreeObject(object)
end

function Clone(object)
end

function RawNew(cls)
end
