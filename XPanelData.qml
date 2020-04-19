import QtQuick 2.0

Rectangle{
    id: r
    width: (xApp.width-x1.width)*0.5
    height: xApp.height
    color: app.c1
    Column{
        spacing: app.fs
        anchors.centerIn: r
        Rectangle{
            id: xScoreTopFive
            width: r.width-app.fs
            height: colHS.height+app.fs
            color: app.c3
            Column{
                id: colHS
                spacing: app.fs*0.25
                anchors.centerIn: parent
                Rectangle{
                    width: xScoreTopFive.width-app.fs
                    height: app.fs*3
                    color: app.c2
                    border.width: 1
                    border.color: app.c2
                    UText{
                        text:  '<b>Top Five Records</b>'
                        font.pixelSize: app.fs*1.5
                        color: app.c1
                        anchors.centerIn: parent
                    }
                }
                Repeater{
                    id: repHS
                    model: []
                    Rectangle{
                        width: xScoreTopFive.width-app.fs
                        height: app.fs*2
                        border.width: 2
                        border.color: app.c2
                        radius: app.fs*0.5
                        color: app.c1
                        UText{
                            text:  '<b>'+parseInt(index + 1)+'</b>:'+modelData+' '+r.a2[index]+' pts.'
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
        UText{
            width: r.width*0.8
            height: contentHeight
            text: 'Si envías por el chat el comando "!a" (escribe signo de exclamación y la letra "a")lanzarás una nave en esta depuración del video. \n\nSi quieres aporta una idea, envíame tu nave en formato png a nextsigner@gmail.com\n\nTambién puedes enviar audios de Whatsapp, para saber cómo envía !wsp en el chat.\n\nMi Whatsapp es +54 11 3802 4370'
            font.pixelSize: app.fs*0.5
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    property var objData: ({})
    property var a1: []
    property var a2: []
    Component.onCompleted: {
        for(let i=0;i<5;i++){
            r.a1.push('Nadie')
            r.a2.push(0)
            //r.objData['nn'+parseint(i+1)]='Nadie'
            //r.objData['pts'+parseint(i+1)]=0
        }
        repHS.model=r.a1
    }
    function setHS(nn, hs){
        let na1=[]
        let na2=[]
        let mant1=[]
        let mant2=[]
        let mpost1=[]
        let mpost2=[]
        let npos=-1
        let nprev=0
        for(let i=0;i<5;i++){
            if(r.a2[i]>=hs){
                mant1.push(nn)
                mant2.push(hs)
            }
        }
        if(mant2.length>=5){
            r.a1=na1
            r.a2=na2
            repHS.model=na1
            return
        }
        na1.push(nn)
        na2.push(hs)
        for(let i2=mant2.length-1;i2<5-mant2.length-1;i2++){
            na1.push(r.a1[i2])
            na2.push(r.a2[i2])
        }
        r.a1=na1
        r.a2=na2
        repHS.model=na1

    }
}
