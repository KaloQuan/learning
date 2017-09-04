;(function ($, window, document, undefined) {
    $.fn.simpleTable = function (options) {
        //默认配置
        var defaults = {
            data: {}
        };
        //合并配置
        var settings = $.extend(defaults, options);

        return this.each(function (index, ele) {
            var simpleTable = new SimpleTable(ele);

            simpleTable.show();
        });
    };
})(jQuery, window, document);

var SimpleTable = (function () {
    //构造函数
    function SimpleTable(selector) {
        _selector = selector;
    }

    //私有变量，外部不可访问
    var _selector;

    //私有函数，外部不可访问
    function _get() {

    }

    SimpleTable.prototype = {
        //实例变量,外部可访问
        version: "instance version 1.0.0",
        //实例方法,外部可访问
        getSelector: function () {
            return _selector;
        },
        show: function () {
            alert("This is instance method .");
        }
    };

    //静态变量
    SimpleTable.version = "static version 2.0.0";

    //静态方法
    SimpleTable.show = function () {
        alert("This is static method .");
    };

    return SimpleTable;
})();