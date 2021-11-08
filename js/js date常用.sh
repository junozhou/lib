
#js获取当天时间以及当天时间的0点及24点，并标准化为YYYY-MM-DD HH:MM:SS

      var date1 = new Date(new Date(new Date().toLocaleDateString()).getTime());
      var date2 = new Date(new Date(new Date().toLocaleDateString()).getTime() + 24 * 60 * 60 * 1000 - 1);

      var startTime = date1.getFullYear() +
      "-" +
      ((date1.getMonth() + 1) < 10 ? "0" + (date1.getMonth() + 1) : (date1.getMonth() + 1))+
      "-" +
      (date1.getDate() < 10 ? "0" + date1.getDate() : date1.getDate()) +
      " " +
      (date1.getHours()<10 ? "0"+date1.getHours() : date1.getHours()) +
      ":" +
      (date1.getMinutes()<10 ? "0"+date1.getMinutes() : date1.getMinutes()) +
      ":" +
      (date1.getSeconds()<10 ? "0"+date1.getSeconds() : date1.getSeconds());

      var endTime = date2.getFullYear() +
      '-' +
      (date2.getMonth() + 1) +
      '-' +
      date2.getDate() +
      ' ' +
      date2.getHours() +
      ':' +
      date2.getMinutes() +
      ':' +
      date2.getSeconds();