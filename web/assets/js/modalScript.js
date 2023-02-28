let request = new XMLHttpRequest();
let button_id = 1;

function searchActor(actorName) {
    // request.open("Post", "../CinemaSearchServlet?cityId=" + encodeURIComponent(document.getElementById("cityId").value), true);
    request.open("Post", "../ActorSearchServlet?actorName=" + actorName, true);

    // console.log("request: " + request)
    request.send(null);
}

function searchDirector(actorName) {
    // request.open("Post", "../CinemaSearchServlet?cityId=" + encodeURIComponent(document.getElementById("cityId").value), true);
    request.open("Post", "../ActorSearchServlet?actorName=" + actorName, true);
    request.onreadystatechange = searchProcess_director;
    // console.log("request: " + request)
    request.send(null);
}

let is_checked_actor = function () {
    console.log(this.id)
    let id = this.id;

    let num = id.split('_')[1]; //배우번호
    let parentEl = this.parentElement;
    console.log(parentEl)
    console.log(parentEl.innerText); //권주희
    let selectName = parentEl.innerText;

    if ($('#' + id).is(':checked')) { //true
        // 체크박스를 클릭하면 클락한 요소들이 밑에 쌓이고 다시 검색할 수 있게 한다. (밑에 쌓이는 div에는 삭제버튼도 있어야 한다.)
        let newCheckDiv = document.getElementById("actorBT");
        let newButton = document.createElement("input")
        let hiddenId = document.createElement("input")
        newButton.className = "btn btn-primary actorButton m-2";
        newButton.type = "text";
        newButton.id = "modalButton_" + num;
        newButton.onclick = deleteActor;
        newButton.defaultValue = selectName;
        newButton.name = "actor";

        hiddenId.style.display = "none";
        hiddenId.defaultValue = num;
        hiddenId.name = "actor_id";

        newCheckDiv.appendChild(newButton);
        newCheckDiv.appendChild(hiddenId);

        // newCheckDiv.innerHTML = 현재클릭한 checkBox value
    } else { //false
        //delete 문 실행
        deleteActor(this);
    }
}

//감독
let is_checked_director = function () {
    console.log(this.id)
    let id = this.id;

    let num = id.split('_')[1]; //감독번호
    let parentEl = this.parentElement;
    console.log(parentEl)
    console.log(parentEl.innerText); //권주희
    let selectName = parentEl.innerText;

    if ($('#' + id).is(':checked')) { //true
        // 체크박스를 클릭하면 클락한 요소들이 밑에 쌓이고 다시 검색할 수 있게 한다. (밑에 쌓이는 div에는 삭제버튼도 있어야 한다.)
        let newCheckDiv = document.getElementById("directorBT");
        let newButton = document.createElement("input")
        let hiddenId = document.createElement("input")
        let hiddenCasting = document.createElement("input")
        newButton.className = "btn btn-primary actorButton m-2";
        newButton.type = "text";
        newButton.id = "modalButton_" + num;
        newButton.onclick = deleteDirector;
        newButton.defaultValue = selectName;
        newButton.name = "director";

        hiddenId.style.display = "none";
        hiddenId.defaultValue = num;
        hiddenId.name = "director_id";

        hiddenCasting.style.display = "none";
        hiddenCasting.defaultValue = "0";
        hiddenCasting.name = "casting";

        newCheckDiv.appendChild(newButton);
        newCheckDiv.appendChild(hiddenId);
        newCheckDiv.appendChild(hiddenCasting)

        // newCheckDiv.innerHTML = 현재클릭한 checkBox value
    } else { //false
        //delete 문 실행
        deleteDirector(this);
    }


}


function searchProcess_actor() {
    console.log("searchProcess 진입")

    if (request.readyState == 4 && request.status == 200) {
        let selectForm = document.getElementById("actor_form")
        selectForm.innerText = "";
        //다시 검색기능 그리기
        let searchDiv = document.createElement("div");
        searchDiv.className = "form-group";

        let temp = JSON.parse(request.responseText);
        let array = JSON.parse(temp.responseText);


        for (let i = 0; i < array.length; i++) {
            let newDiv = document.createElement("div");
            let newInput = document.createElement("input");
            newDiv.className = "form-check m-2";
            newInput.className = "form-check-input";
            newInput.type = "checkbox";
            newInput.id = "checkBox_" + array[i].id;
            newDiv.id = "checkDiv_" + array[i].id;
            newInput.onchange = is_checked_actor;
            newDiv.innerHTML = array[i].name;

            newDiv.appendChild(newInput)
            searchDiv.appendChild(newDiv);
            selectForm.appendChild(searchDiv);
        }

    }

    window.onload = function () {
        searchActor();

    }
}

//감독
function searchProcess_director() {

    if (request.readyState == 4 && request.status == 200) {
        let selectForm = document.getElementById("director_form")
        selectForm.innerText = "";
        //다시 검색기능 그리기
        let searchDiv = document.createElement("div");
        searchDiv.className = "form-group";

        let temp = JSON.parse(request.responseText);
        let array = JSON.parse(temp.responseText);


        for (let i = 0; i < array.length; i++) {
            let newDiv = document.createElement("div");
            let newInput = document.createElement("input");
            newDiv.className = "form-check m-2";
            newInput.className = "form-check-input";
            newInput.type = "checkbox";
            newInput.id = "checkBox_" + array[i].id;
            newDiv.id = "checkDiv_" + array[i].id;
            newInput.onchange = is_checked_director;
            newDiv.innerHTML = array[i].name;

            newDiv.appendChild(newInput)
            searchDiv.appendChild(newDiv);
            selectForm.appendChild(searchDiv);
        }
    }

    window.onload = function () {
        searchDirector();

    }
}

let deleteActor = function (obj) {
    console.log("deleteActor!! ")

    try {
        //체크박스 해제
        console.log(obj);
        let num = (obj.id).split('_')[1]; //배우 id
        let deleteObj = document.getElementById("modalButton_" + num);
        console.log("deleteObj : " + deleteObj)
        deleteObj.remove();
    } catch (e) {
        try {
            //직접 버튼 클릭해서 삭제
            console.log(this.id);
            let num = (this.id).split('_')[1];
            let deleteObj = document.getElementById("modalButton_" + num);
            deleteObj.remove();
            let checkNum = "checkBox_" + num;
            console.log($('#' + this.id).prop("checked", false));
            $('#' + checkNum).prop("checked", false);
        } catch (e) {

        }
    }
}

//감독
let deleteDirector = function (obj) {
    console.log("deleteActor!! ")

    try {
        //체크박스 해제
        console.log(obj);
        let num = (obj.id).split('_')[1]; //배우 id
        let deleteObj = document.getElementById("modalButton_" + num);
        console.log("deleteObj : " + deleteObj)
        deleteObj.remove();
    } catch (e) {
        try {
            //직접 버튼 클릭해서 삭제
            console.log(this.id);
            let num = (this.id).split('_')[1];
            let deleteObj = document.getElementById("modalButton_" + num);
            deleteObj.remove();
            let checkNum = "checkBox_" + num;
            console.log($('#' + this.id).prop("checked", false));
            $('#' + checkNum).prop("checked", false);
        } catch (e) {

        }
    }

}

