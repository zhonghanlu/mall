<template>
  <div class="login">
    <el-form ref="loginRef" :model="loginForm" :rules="loginRules" class="login-form">
      <h3 class="title">{{ SYSTEM_NAME }}</h3>
      <el-tabs v-model="activeName" type="border-card" @tab-change="handleChange" class="custom-tabs">
        <el-tab-pane label="商家端" name="merchant" class="custom-tab-pane">
        </el-tab-pane>
        <el-tab-pane label="配送端" name="delivery" class="custom-tab-pane">
        </el-tab-pane>
        <el-tab-pane label="用户端" name="mall" class="custom-tab-pane">
        </el-tab-pane>
        <el-tab-pane label="管理端" name="manager" class="custom-tab-pane">
        </el-tab-pane>
        <el-form-item prop="username">
          <el-input
              v-model="loginForm.username"
              size="large"
              placeholder="账号"
              prefix-icon="user"
              @keyup.enter="handleLogin"
          />
        </el-form-item>
        <el-form-item prop="password">
          <el-input
              v-model="loginForm.password"
              type="password"
              size="large"
              placeholder="密码"
              prefix-icon="lock"
              @keyup.enter="handleLogin"
          />
        </el-form-item>
        <el-form-item prop="code" v-if="captchaEnabled">
          <el-input
              v-model="loginForm.code"
              size="large"
              placeholder="验证码"
              style="width: 63%"
              prefix-icon="key"
              @keyup.enter="handleLogin"
          />
          <div class="login-code">
            <img :src="codeUrl" @click="getCode" class="login-code-img" alt="验证码"/>
          </div>
        </el-form-item>
        <el-checkbox v-model="loginForm.rememberMe">记住密码</el-checkbox>
        <el-form-item style="width:100%;">
          <el-button
              :loading="loading"
              size="large"
              type="primary"
              style="width:100%;"
              @click.prevent="handleLogin"
          >
            <span v-if="!loading">登 录</span>
            <span v-else>登 录 中...</span>
          </el-button>
          <div style="float: right;" v-if="register">
            <router-link class="link-type" :to="'/register?system='+activeName">立即注册</router-link>
          </div>
        </el-form-item>
      </el-tabs>
    </el-form>
  </div>
</template>

<script setup>
import {ref, watch} from 'vue';
import {useRouter, useRoute} from 'vue-router';
import {ElForm} from 'element-plus'; // 确保引入ElForm
import {getCodeImg} from '@/api/login';
import Cookies from 'js-cookie';
import {encrypt, decrypt} from '@/utils/jsencrypt';
import useUserStore from '@/store/modules/user';

const userStore = useUserStore();
const router = useRouter();
const route = useRoute();

// 初始化默认选中的标签为商家端
const activeName = ref("merchant");
const SYSTEM_NAME = ref("商家端管理系统");

const loginForm = ref({
  username: "",
  password: "",
  rememberMe: false,
  code: "",
  uuid: "",
  clientName: ""
});

const loginRules = {
  username: [{required: true, trigger: "blur", message: "请输入您的账号"}],
  password: [{required: true, trigger: "blur", message: "请输入您的密码"}],
  code: [{required: true, trigger: "change", message: "请输入验证码"}]
};

const codeUrl = ref("");
const loading = ref(false);
// 验证码开关
const captchaEnabled = ref(true);
// 注册开关
const register = ref(true);
const redirect = ref(undefined);

const loginRef = ref(null); // 绑定表单引用

watch(route, (newRoute) => {
  redirect.value = newRoute.query?.redirect;
}, {immediate: true});

// 处理选择tag
function handleChange(tab, event) {
  if (activeName.value === "merchant") {
    SYSTEM_NAME.value = "商家端管理系统";
    route.query.redirect = '/shop/category'
  } else if (activeName.value === "delivery") {
    SYSTEM_NAME.value = "配送端管理系统";
    route.query.redirect = '/delivery/take'
  } else if (activeName.value === "mall") {
    SYSTEM_NAME.value = "用户端商城系统";
    route.query.redirect = '/mall'
  } else if (activeName.value === "manager") {
    SYSTEM_NAME.value = "管理端管理系统";
    route.query.redirect = '/system/user'
  }
  // 重置表单
  loginForm.value.username = null;
  loginForm.value.password = null;
  loginForm.value.code = null;
  loginForm.value.uuid = null;
  getCode();
}

function handleLogin() {
  console.log(12312321)
  loginRef.value.validate((valid) => {
    console.log(valid)
    if (valid) {
      loading.value = true;
      // 勾选了需要记住密码设置在 cookie 中设置记住用户名和密码
      if (loginForm.value.rememberMe) {
        Cookies.set("username", loginForm.value.username, {expires: 30});
        Cookies.set("password", encrypt(loginForm.value.password), {expires: 30});
        Cookies.set("rememberMe", loginForm.value.rememberMe, {expires: 30});
      } else {
        // 否则移除
        Cookies.remove("username");
        Cookies.remove("password");
        Cookies.remove("rememberMe");
      }
      // 调用action的登录方法
      loginForm.value.clientName = activeName.value
      userStore.login(loginForm.value).then(() => {
        const query = route.query;
        // 默认跳转商家端
        redirect.value = query.redirect === '/index' ? "/shop/category" : query.redirect;
        const otherQueryParams = Object.keys(query).reduce((acc, cur) => {
          if (cur !== "redirect") acc[cur] = query[cur];
          return acc;
        }, {});
        router.push({path: redirect.value || "/", query: otherQueryParams});
      }).catch(() => {
        loading.value = false;
        // 重新获取验证码
        if (captchaEnabled.value) getCode();
      });
    }
  });
}

function getCode() {
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled ?? true;
    if (captchaEnabled.value) {
      codeUrl.value = `data:image/gif;base64,${res.img}`;
      loginForm.value.uuid = res.uuid;
    }
  });
}

function getCookie() {
  const username = Cookies.get("username");
  const password = Cookies.get("password");
  const rememberMe = Cookies.get("rememberMe");
  loginForm.value = {
    username: username || loginForm.value.username,
    password: password ? decrypt(password) : loginForm.value.password,
    rememberMe: Boolean(rememberMe)
  };
}

getCode();
getCookie();
</script>


<style lang="scss" scoped>
.login {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background-image: url("../assets/images/login-background.jpg");
  background-size: cover;
  background-position: center;
}

.title {
  margin: 0 auto 30px;
  text-align: center;
  color: #707070;
  font-size: 24px;
  font-weight: bold;
}

.login-form {
  border-radius: 8px;
  background: rgba(255, 255, 255, 0.9);
  width: 500px;
  padding: 30px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;

  &:hover {
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
  }

  .el-input {
    height: 48px;

    input {
      height: 48px;
      font-size: 16px;
    }
  }

  .input-icon {
    height: 48px;
    width: 16px;
    margin-left: 0;
  }
}

.custom-tabs {
  margin-bottom: 20px;

  .custom-tab-pane {
    padding: 10px;
  }

  .custom-tab-label {
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: color 0.3s ease;

    i {
      font-size: 18px;
    }

    &:hover {
      color: #409eff;
    }
  }
}

.login-code {
  width: 33%;
  height: 48px;
  float: right;

  img {
    cursor: pointer;
    vertical-align: middle;
    height: 48px;
    padding-left: 12px;
  }
}

.el-login-footer {
  height: 40px;
  line-height: 40px;
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #fff;
  font-family: Arial;
  font-size: 12px;
  letter-spacing: 1px;
  background-color: rgba(0, 0, 0, 0.5);
}

.register-link {
  float: right;
  color: #409eff;
  font-size: 14px;
  cursor: pointer;
}
</style>
