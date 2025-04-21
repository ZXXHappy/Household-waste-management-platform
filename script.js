// 模拟数据
const mockData = {
  userScore: 1000,
  tableData: [
    {
      id: 1,
      name: '商品1',
      descr: '这是商品1的描述',
      num: 10,
      unit: '件',
      score: 100,
      img: 'https://via.placeholder.com/300'
    },
    {
      id: 2,
      name: '商品2',
      descr: '这是商品2的描述',
      num: 20,
      unit: '个',
      score: 200,
      img: 'https://via.placeholder.com/300'
    }
  ],
  total: 2,
  pageNum: 1,
  pageSize: 10
};

// 获取 DOM 元素
const searchInput = document.getElementById('search-input');
const searchButton = document.getElementById('search-button');
const resetButton = document.getElementById('reset-button');
const pagination = document.getElementById('pagination');
const exchangeDialog = document.getElementById('exchange-dialog');
const exchangeForm = document.getElementById('exchange-form');
const cancelButton = document.getElementById('cancel-button');
const confirmButton = document.getElementById('confirm-button');
const userScoreElement = document.getElementById('user-score');
const goodsNameElement = document.getElementById('goods-name');
const exchangeNumElement = document.getElementById('exchange-num');
const consumeScoreElement = document.getElementById('consume-score');
const receiveNameElement = document.getElementById('receive-name');
const receivePhoneElement = document.getElementById('receive-phone');
const receiveAddressElement = document.getElementById('receive-address');

// 显示用户积分
userScoreElement.textContent = mockData.userScore;

// 渲染商品列表
function renderGoodsList() {
  const elRow = document.querySelector('.el-row');
  elRow.innerHTML = '';
  mockData.tableData.forEach(item => {
    const elCol = document.createElement('div');
    elCol.className = 'el-col';
    elCol.style.flexBasis = '25%';
    elCol.innerHTML = `
      <div class="card" style="padding: 0; margin-bottom: 20px">
        <img src="${item.img}" alt="" style="width: 100%; height: 260px; border-radius: 5px 5px 0 0">
        <div style="padding: 10px">
          <div style="font-size: 20px">${item.name}</div>
          <div style="margin: 10px 0; color: #666; height: 40px; line-height: 20px; text-align: justify" class="line2">${item.descr}</div>
          <div style="margin: 10px 0; color: #666">剩余数量：${item.num} ${item.unit}</div>
          <div style="display: flex; align-items: center">
            <div style="flex: 1; color: red; font-weight: bold">${item.score}积分/${item.unit}</div>
            <button type="button" class="exchange-button">立即兑换</button>
          </div>
        </div>
      </div>
    `;
    elRow.appendChild(elCol);
    const exchangeButton = elCol.querySelector('.exchange-button');
    exchangeButton.addEventListener('click', () => handleExchange(item));
  });
}

// 渲染分页组件
function renderPagination() {
  if (mockData.total > 0) {
    pagination.style.display = 'block';
    // 这里可以根据实际需求添加分页逻辑
  } else {
    pagination.style.display = 'none';
  }
}

// 计算消耗积分
function calScore() {
  const goods = JSON.parse(sessionStorage.getItem('selectedGoods'));
  const num = parseInt(exchangeNumElement.value);
  const score = goods.score * num;
  consumeScoreElement.textContent = score;
}

// 处理兑换按钮点击事件
function handleExchange(goods) {
  sessionStorage.setItem('selectedGoods', JSON.stringify(goods));
  goodsNameElement.textContent = goods.name;
  exchangeNumElement.value = 1;
  calScore();
  exchangeDialog.style.display = 'block';
}

// 处理取消按钮点击事件
cancelButton.addEventListener('click', () => {
  exchangeDialog.style.display = 'none';
});

// 处理确认按钮点击事件
confirmButton.addEventListener('click', () => {
  // 这里可以添加表单验证和提交逻辑
  alert('操作成功');
  exchangeDialog.style.display = 'none';
  renderGoodsList();
});

// 处理查询按钮点击事件
searchButton.addEventListener('click', () => {
  // 这里可以添加查询逻辑
  renderGoodsList();
  renderPagination();
});

// 处理重置按钮点击事件
resetButton.addEventListener('click', () => {
  searchInput.value = '';
  // 这里可以添加重置逻辑
  renderGoodsList();
  renderPagination();
});

// 监听兑换数量输入框变化
exchangeNumElement.addEventListener('input', calScore);

// 初始化页面
renderGoodsList();
renderPagination();