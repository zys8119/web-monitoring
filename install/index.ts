// 安装程序脚本
import axios from "axios"
import {green, yellow, blue} from "chalk"
import ProgressBar from "progress"
import {mkdirSync} from "fs-extra"
import {readFileSync, writeFileSync, createWriteStream, createReadStream} from "fs"
import {execSync} from "child_process"
import {createGzip} from "zlib"

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
    const nginx_cwd = "/usr/local/nginx"
    mkdirSync(nginx_cwd, {recursive:true})
    console.log(blue(`创建目录完成`))
    console.log(blue(`正在下载：nginx`))
    const nginx = await berInit(async (bar:any)=>{
        const {data} = await axios({
            method:"get",
            url:"http://nginx.org/download/nginx-1.22.1.tar.gz",
            responseType:"arraybuffer",
            onDownloadProgress(e:any){
                bar.total = e.total
                bar.next(e.loaded)
            }
        })
        return data
    })
    writeFileSync(nginx_cwd+"/nginx-1.22.1.tar.gz", nginx)
    console.log(blue(`nginx下载完成`))
    console.log(blue(`正在解压nginx-1.22.1`))
    execSync("tar -xvf nginx-1.22.1.tar.gz", {cwd:nginx_cwd})
    execSync("./configure", {cwd:nginx_cwd+"/nginx-1.22.1"})
    execSync("make -y", {cwd:nginx_cwd+"/nginx-1.22.1"})
    execSync("make install -y", {cwd:nginx_cwd+"/nginx-1.22.1"})
    console.log(blue(`解压完成`))
})()
