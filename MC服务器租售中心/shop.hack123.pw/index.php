<?php
    include_once "header.php";
    require_once "config/config.inc.php";
    require_once "config/common.php";
?>

<div class="container">
    <div class="row clearfix">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-10 column">
            <ul class="nav nav-pills">
                <li class="active">
                    <a href="index.php">首页</a>
                </li>
                <?php
                    if (!isset($_SESSION['isLogin'])) {
                        echo <<< EOF
                <li>
                    <a href="login.php">登录</a>
                </li>
EOF;
                    }
                ?>
                <!-- <li class="disabled">
                    <a href="register.php?step=0">注册</a>
                </li> -->
                <?php
                    if (isset($_SESSION['isLogin'])) {
                        echo <<< EOF
                        <li>
                        <a href="pay.php">我要充值</a>
                        </li>
EOF;
                        $count = getAllMyCart($dbConn);
                        echo '<li><a href="mycart.php">我的购物车';
                        echo '(' . $count .')</a>';
                        echo '</li>';
echo <<< EOF
                        <li class="pull-right">
                        <a href="logout.php">注销</a>
                        </li>
EOF;
                    }
                ?>
            </ul>
            <div class="row clearfix">
                <div class="col-md-4 column">
                    <h2>
                        A套餐
                    </h2>
                    <p>
                        支持人数：1-5人<br />
                        CPU：1核<br />
                        内存：1GB<br />
                        SSD：否<br />
                        价格：10元/月
                    </p>
                    <p>
                        <a class="btn" href="#" id="server-a">加入购物车 »</a>
                    </p>
                </div>
                <div class="col-md-4 column">
                    <h2>
                        B套餐 热销中
                    </h2>
                    <p>
                        支持人数：5-10人<br />
                        CPU：2核<br />
                        内存：2GB<br />
                        SSD：否<br />
                        价格：20元/月
                    </p>
                    <p>
                        <a class="btn" href="#" id="server-b">加入购物车 »</a>
                    </p>
                </div>
                <div class="col-md-4 column">
                    <h2>
                        C套餐 热销中
                    </h2>
                    <p>
                        支持人数：10-15人<br />
                        CPU：2核<br />
                        内存：3GB<br />
                        SSD：支持<br />
                        价格：35元/月
                    </p>
                    <p>
                        <a class="btn" href="#" id="server-c">加入购物车 »</a>
                    </p>
                </div>
            </div>
            <div class="row clearfix">
                <div class="col-md-4 column">
                    <h2>
                        D套餐
                    </h2>
                    <p>
                        支持人数：15-25人<br />
                        CPU：4核<br />
                        内存：4GB<br />
                        SSD：支持<br />
                        价格：50元/月
                    </p>
                    <p>
                        <a class="btn" href="#" id="server-d">加入购物车 »</a>
                    </p>
                </div>
                <div class="col-md-4 column">
                    <h2>
                        E套餐
                    </h2>
                    <p>
                        支持人数：25-50人<br />
                        CPU：8核<br />
                        内存：8GB<br />
                        SSD：支持<br />
                        价格：120元/月
                    </p>
                    <p>
                        <a class="btn" href="#" id="server-e">加入购物车 »</a>
                    </p>
                </div>
                <div class="col-md-4 column">
                    <h2>
                        F套餐
                    </h2>
                    <p>
                        支持人数：50人以上<br />
                        CPU：8核<br />
                        内存：16GB<br />
                        SSD：支持<br />
                        价格：180元/月
                    </p>
                    <p>
                        <a class="btn" href="#" id="server-f">加入购物车 »</a>
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-1 column" id="add-result">
        </div>
    </div>
</div>

<?php
    include_once "footer.php";
?>
