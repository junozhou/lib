let obj1={
    name:'关羽',
    sex:'male',
    skill(){
        console.log('看尔乃插标卖首');
    }
};
let obj2={
    house:'赤兔',
    do(){
        console.log('I can run fast!!!');
    }
};

//方法一：利用扩展运算符
let obj3={...obj1,...obj2};
console.log(obj3);

//方法二：利用ES6 Object新增assign方法
let obj4=Object.assign({},obj1,obj2);
console.log(obj4);