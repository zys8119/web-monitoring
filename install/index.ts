// 安装程序脚本
import axios from "axios"
import {green, yellow, blue} from "chalk"
import ProgressBar from "progress"
import {mkdirSync} from "fs-extra"
import {readFileSync, writeFileSync} from "fs"
import {execSync} from "child_process"
const logStr = (str:string)=>{
    return str.split("\n").map(e=>e.trim()).filter(e=>e).join("\n")
}
const berInit = async (callback:any)=>{
    return new Promise<any>(resolve => {
        (async ()=>{
            const bar = new ProgressBar(`${blue('当前进度')} ${green(':percent')} :bar 已处理(${green(':current')}/:total})文件\n`, {
                total: 0,
                width: 50,
                clear:true
            });
            (bar as any).next = (count:number)=>{
                bar.tick(count)
            }
            const res = await callback(bar)
            if(bar.complete){
                resolve(res)
            }
        })()
    })

}
;(async ()=>{
    console.log(yellow(logStr(`
       /**安装程序脚本**/
    `)))
    console.log(blue(`创建目录：packages`))
    mkdirSync('./packages', {recursive:true})
    console.log(blue(`创建目录完成`))
    console.log(blue(`正在下载：nginx`))
    const nginx = await berInit(async (bar:any)=>{
        const {data} = await axios({
            method:"get",
            url:"http://nginx.org/download/nginx-1.22.1.tar.gz",
            responseType:"blob",
            onDownloadProgress(e:any){
                bar.total = e.total
                bar.next(e.loaded)
            }
        })
        return data
    })
    writeFileSync("./packages/nginx-1.22.1.tar.gz", nginx)
    console.log(blue(`nginx下载完成`))
    console.log(blue(`正在解压nginx-1.22.1.tar.gz`))
    execSync("tar -xvf ./packages/nginx-1.22.1.tar.gz")
    console.log(blue(`解压完成`))
    execSync("tail -f /dev/null")
    console.log(blue(`挂起服务`))
})()
