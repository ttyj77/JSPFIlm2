$(function () {
    $("#datepicker").datepicker({dateFormat: 'yy/mm/dd'});

});

function setMinValue() {
    const today = new Date();
    let choiceDate = $('#datepicker').val();

    console.log(choiceDate)
    console.log(today.toLocaleDateString());
    printPT(choiceDate);

}

function printPT(choiceDate) {
    let sendData = {
        "date": choiceDate,
        "id": $('#cinemaId').val()
    }
    console.log($('#cinemaId').val())
    console.log(choiceDate)
    $.ajax({
        url: "/cinema/runningTime",
        method: "get",
        data: sendData,
        success: (message) => {
            let response = JSON.parse(message);
            console.log(response)
            let replyArray = JSON.parse(response.list);
            const film_id = []

            //film id list 생성
            replyArray.forEach(reply => {
                if (!film_id.includes(reply.id)) {
                    film_id.push(reply.id)
                    let titleBox = $(document.getElementById("titleBox")) //영화 이름 상영시간 들어가는 박스
                    let p = $(document.createElement("p"))
                    let Ta = $(document.createElement("a")).attr("href","/index.jsp").text(reply.title)
                    $(p).append(Ta)
                    $(titleBox).append(p)
                }
                //여기서 영화 큰 틀 그리고
                console.log(film_id)
            })
            replyArray.forEach(reply => {

                    var id = reply.id
                    var step;
                    for (step = 0; step < film_id.length; step++) {
                        //여기서 내용 채우기
                        console.log("1 : " + film_id[step])
                        console.log("2 :" + id)
                        if (film_id[step] == id) {
                            console.log(film_id[step] == id)
                            let div_box = $(document.createElement("div")).addClass("reply_box")
                            let div_1 = $(document.createElement("div")).addClass("col-1_5")
                            let div_2 = $(document.createElement("div")).addClass("col-10 content")
                            let h1 = $(document.createElement("h1"))
                            let h4 = $(document.createElement("h4"))
                            let p = $(document.createElement("p")).addClass("m-3")
                            h1.text(reply.score)
                            $(div_1).append(h1)

                        }
                        //
                        // else {
                        //     console.log("includes false")
                        //     let f_title_a = $(document.createElement("a"))
                        //     let f_title_p = $(document.createElement("p"))
                        //     f_title_a.text(reply.title)
                        //     f_title_p.append(f_title_a)
                        //     titleBox.append(f_title_p)
                        // }
                    }
                }
            )
            // printList(replyArray);
        }
    })
}