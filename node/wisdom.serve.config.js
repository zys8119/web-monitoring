"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const crypto_1 = require("crypto");
const post_connect_user = function (key, data, isAdmin) {
    return __awaiter(this, void 0, void 0, function* () {
        // 客户端唯一id
        const client_id = (0, crypto_1.createHash)("md5").update(JSON.stringify(data)).digest("hex");
        const postData = {
            client_key: key,
            client_id,
            is_admin_client: isAdmin ? 2 : 1
        };
        if (!isAdmin) {
            const [{ client_key } = {}] = yield this.$DBModel.tables.connect_user.get({
                where: {
                    is_admin_client: { value: 2 },
                    client_id: { value: client_id, and: true },
                }
            });
            if (client_key) {
                postData.parent_client_key = client_key;
            }
            else {
                if (global.$socketList[key]) {
                    global.$socketList[key].socket.end();
                    delete global.$socketList[key];
                }
                return;
            }
        }
        yield this.$DBModel.tables.connect_user.post(postData);
    });
};
exports.default = {
    mysqlAuto: /^\/syncMysqlAuto/,
    debug: false,
    query_params: true,
    cors: true,
    corsHeaders: "token,content-type",
    credentials: true,
    websocket: {
        "connect-login"({ payload, key }) {
            (() => __awaiter(this, void 0, void 0, function* () {
                if (payload.id) {
                    const [{ user_id, user_tag, device_log, app_id, project_version } = {}] = yield this.$DBModel.tables.log_pv.get({
                        where: {
                            id: { value: payload.id }
                        }
                    });
                    const log = JSON.parse(Buffer.from(device_log, "base64").toString());
                    yield post_connect_user.call(this, key, {
                        user_id,
                        user_tag,
                        visitorId: log.visitorId,
                        app_id,
                        project_version
                    }, true);
                }
                else {
                    yield post_connect_user.call(this, key, payload.data, false);
                }
                global.$socketSend(JSON.stringify({
                    emit: 'connect-login-success'
                }), [key]);
            }))();
        },
        "connect-send"({ payload, key }) {
            (() => __awaiter(this, void 0, void 0, function* () {
                if (payload.id) {
                    // 服务端
                    const res = yield this.$DBModel.tables.connect_user.get({
                        where: {
                            parent_client_key: { value: key },
                            is_admin_client: { value: 1, and: true },
                        }
                    });
                    global.$socketSend(JSON.stringify(payload), res.map(e => e.client_key));
                }
                else {
                    // 客户端
                    const [{ parent_client_key } = {}] = yield this.$DBModel.tables.connect_user.get({
                        where: {
                            client_key: { value: key }
                        }
                    });
                    if (parent_client_key) {
                        global.$socketSend(JSON.stringify(payload), [parent_client_key]);
                    }
                }
            }))();
        },
        "ws-close"({ key }) {
            (() => __awaiter(this, void 0, void 0, function* () {
                yield this.$DBModel.tables.connect_user.delete({
                    where: {
                        client_key: { value: key }
                    }
                });
            }))();
        }
    },
    CorePlugConfig: {
        staticPulgin: {
            extHeader: {
                '.jpeg': {
                    "access-control-allow-origin": "*",
                    // "access-control-allow-methods":"*",
                    // "access-control-allow-headers":"*",
                }
            }
        }
    },
    mysqlConfig: {
        connectionLimit: 100,
        host: '127.0.0.1',
        port: 3306,
        user: 'root',
        password: 'rootroot',
        database: "system_monitoring_node",
        prefix: ""
    },
    serve: {
        port: 40010
    },
    noticeConfig: {
    }
};
