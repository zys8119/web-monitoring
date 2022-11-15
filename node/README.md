## 系统监控 服务端 node版本

### 参考地址

[webfunny](https://webfunny.zhijiasoft.com/webfunny/home.html)


### 埋点推荐配置

```typescript
import {ConsolePulgConfig } from 'vue-console-pulg'

export default {
    consoleMap:['error', 'log'],
    eventMap: ['error', 'messageerror', 'unhandledrejection', 'rejectionhandled', 'click'],
    AxiosConfig:{
        baseURL:import.meta.env.VITE_Log_API,
        url:'/log/up',
        method:'post',
    },
    eventMapCallback(data: any): Promise<any> {
        if (['click'].includes(data.keyName)) {
            data.selector = data.event.path.reverse().map((e:HTMLElement) => {
                const _id = e.id ? `#${e.id}` : ''
                const _className = e.className ? `${e.className.split(' ').filter(e => /\S/.test(e)).map(e => `.${e}`)}` : ``
                return `${e?.tagName?.toLocaleLowerCase() || ''}${_id}${_className}`
            }).filter((e:any) => /\S/.test(e)).join('>')
        }
        return Promise.resolve(data)
    },
    getCustomData(data, fp): Promise<any> {
        const _this:any = this
        const main:any = window.store.main
        const {userinfo:{id:user_id, name:user_tag} = {} as any} = main
        if ([`XHL_Success_Error`,`XHL_Error`,`XHL_Success`].includes(data.type) && /\/log\/(up|pv)/.test(data.errorData.data.openArgs[1])) {
            return Promise.reject()
        }
        return Promise.resolve({
            url:data.type === 'PV' ? '/log/pv' : _this.config.AxiosConfig?.url,
            data: {
                log:data,
                user_id:user_id || fp.visitorId,
                user_tag:user_tag || '未知',
                type:data.type,
                app_id:'5fa1ca70-f5e4-11ec-becd-a99a91db4246',
                project_version:'v1.0.0',
            }
        })
    }
} as ConsolePulgConfig<keyof WindowEventMap>

```
