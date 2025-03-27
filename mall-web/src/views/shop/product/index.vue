<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="商品名称" prop="productName">
        <el-input
            v-model="queryParams.productName"
            placeholder="请输入商品名称"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="分类">
        <el-select v-model="queryParams.categoryId" placeholder="请选择" clearable style="width: 240px">
          <el-option v-for="item in categoryList" :key="item.id" :label="item.categoryName"
                     :value="item.id"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="标签">
        <el-select v-model="queryParams.labelIdList" multiple placeholder="请选择" clearable style="width: 240px">
          <el-option v-for="item in labelList" :key="item.id" :label="item.labelName"
                     :value="item.id"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="上下架">
        <el-select v-model="queryParams.productStatus" placeholder="请选择" clearable style="width: 240px">
          <el-option key="0" label="下架" value="0"></el-option>
          <el-option key="1" label="上架" value="1"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="primary"
            plain
            icon="Plus"
            @click="handleAdd"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="success"
            plain
            icon="Edit"
            :disabled="single"
            @click="handleUpdate"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="danger"
            plain
            icon="Delete"
            :disabled="multiple"
            @click="handleDelete"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="warning"
            plain
            icon="Download"
            @click="handleExport"
        >导出
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="productList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="主键 id" align="center" prop="id"/>
      <el-table-column label="图片预览" align="center" prop="fileUrl" width="100">
        <template #default="scope">
          <image-preview :src="scope.row.fileUrl" :width="50" :height="50"/>
        </template>
      </el-table-column>
      <el-table-column label="商品名称" align="center" prop="productName"/>
      <el-table-column label="分类名称" width="120">
        <template #default="scope">
          <el-tag>{{ scope.row.categoryName }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          prop="shopLabelList"
          label="标签名称"
          width="120"
      >
        <template #default="{ row }">
          <el-tag
              v-for="label in row.shopLabelList"
              :key="label.id"
              class="tag-item"
              type="primary"
          >
            {{ label.labelName }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="商品优惠价格" align="center" prop="productPrice"/>
      <el-table-column label="商品实际价格" align="center" prop="productActualPrice"/>
      <el-table-column label="商品状态" width="120">
        <template #default="scope">
          <el-tag>{{ scope.row.productStatus === 0 ? "下架" : "上架" }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="商品库存" align="center" prop="productInventory"/>
      <el-table-column label="商品简介" align="center" prop="productIntro"
                       width="240"
                       show-overflow-tooltip/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
          >修改
          </el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
          >删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total>0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
    />

    <!-- 添加或修改商品对话框 -->
    <el-dialog :title="title" v-model="open" width="700px" append-to-body>
      <el-form ref="productRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="商品名称" prop="productName">
          <el-input v-model="form.productName" placeholder="请输入商品名称"/>
        </el-form-item>
        <el-form-item label="图片实际地址" prop="fileUrl">
          <image-upload v-model="form.fileUrl"/>
        </el-form-item>
        <el-form-item label="分类">
          <el-select v-model="form.categoryId" placeholder="请选择" clearable style="width: 240px">
            <el-option v-for="item in categoryList" :key="item.id" :label="item.categoryName"
                       :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="标签">
          <el-select v-model="form.labelIdList" multiple placeholder="请选择" clearable style="width: 240px">
            <el-option v-for="item in labelList" :key="item.id" :label="item.labelName"
                       :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="优惠价格" prop="productPrice">
          <el-input v-model="form.productPrice" placeholder="请输入优惠价格"/>
        </el-form-item>
        <el-form-item label="实际价格" prop="productActualPrice">
          <el-input v-model="form.productActualPrice" placeholder="请输入实际价格"/>
        </el-form-item>
        <el-form-item label="商品库存" prop="productInventory">
          <el-input v-model="form.productInventory" placeholder="请输入商品库存"/>
        </el-form-item>
        <el-form-item label="上下架">
          <el-select v-model="form.productStatus" placeholder="请选择" clearable style="width: 240px">
            <el-option label="下架" :value="0"></el-option>
            <el-option label="上架" :value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="商品简介" prop="productIntro">
          <el-input v-model="form.productIntro" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Product">
import {listProduct, getProduct, delProduct, addProduct, updateProduct} from "@/api/system/product.js";
import {listCategory} from "@/api/system/category.js";
import {listLabel} from "@/api/system/label.js";

const {proxy} = getCurrentInstance();

const productList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

// 分类数据
const categoryList = ref([]);
// 标签数据
const labelList = ref([]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    productName: null,
    categoryId: null,
    labelIdList: null,
    labelName: null,
    productPrice: null,
    productActualPrice: null,
    productStatus: null,
    productInventory: null,
    productIntro: null,
  },
  rules: {
    productName: [
      {required: true, message: "商品名称不能为空", trigger: "blur"}
    ],
    fileUrl: [
      {required: true, message: "图片实际地址不能为空", trigger: "blur"}
    ],
    categoryId: [
      {required: true, message: "分类不能为空", trigger: "change"}
    ],
    labelIdList: [
      {required: true, message: "标签不能为空", trigger: "change"},
      {validator: validateLabelIdList, trigger: "change"}
    ],
    productPrice: [
      {required: true, message: "商品优惠价格不能为空", trigger: "blur"},
      {validator: validatePrice, trigger: "blur"}
    ],
    productActualPrice: [
      {required: true, message: "商品实际价格不能为空", trigger: "blur"},
      {validator: validatePrice, trigger: "blur"}
    ],
    productInventory: [
      {required: true, message: "商品库存不能为空", trigger: "blur"},
      {validator: validateInventory, trigger: "blur"}
    ],
  }
});

const {queryParams, form, rules} = toRefs(data);

// 自定义验证规则
function validateLabelIdList(rule, value, callback) {
  if (!value || value.length === 0) {
    callback(new Error("标签不能为空"));
  } else {
    callback();
  }
}

function validatePrice(rule, value, callback) {
  if (!value) {
    callback(new Error("价格不能为空"));
  } else if (!/^\d+(\.\d{1,2})?$/.test(value)) {
    callback(new Error("请输入有效的价格（最多两位小数）"));
  } else {
    callback();
  }
}

function validateInventory(rule, value, callback) {
  if (!value) {
    callback(new Error("库存不能为空"));
  } else if (!/^\d+$/.test(value)) {
    callback(new Error("请输入有效的库存数量"));
  } else {
    callback();
  }
}

/** 查询商品列表 */
function getList() {
  loading.value = true;
  listProduct(queryParams.value).then(response => {
    productList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

/** 查询分类数据  */
function getCategoryList() {
  listCategory().then(response => {
    categoryList.value = response.rows;
  })
}

/** 查询标签数据  */
function getLabelList() {
  listLabel().then(response => {
    labelList.value = response.rows;
  })
}

// 取消按钮
function cancel() {
  open.value = false;
  reset();
}

// 表单重置
function reset() {
  form.value = {
    id: null,
    productName: null,
    fileUrl: null,
    categoryId: null,
    categoryName: null,
    labelName: null,
    productPrice: null,
    productActualPrice: null,
    productStatus: null,
    productInventory: null,
    productIntro: null,
  };
  proxy.resetForm("productRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加商品";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _id = row.id || ids.value
  getProduct(_id).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改商品";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["productRef"].validate(valid => {
    if (valid) {
      if (form.value.categoryId == null || form.value.labelIdList == null) {
        proxy.$modal.msgError("分类与标签不允许为空");
        return;
      }
      if (form.value.id != null) {
        updateProduct(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addProduct(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id || ids.value;
  proxy.$modal.confirm('是否确认删除商品编号为"' + _ids + '"的数据项？').then(function () {
    return delProduct(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('system/product/export', {
    ...queryParams.value
  }, `product_${new Date().getTime()}.xlsx`)
}

getCategoryList();
getLabelList();
getList();

</script>