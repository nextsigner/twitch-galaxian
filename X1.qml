import QtQuick 2.5
import QtMultimedia 5.0
import QtQuick.Particles 2.0
import "funcs.js" as JS

Rectangle {
    id: r
    width: parent.width*0.8
    height: parent.height
    color: app.c1
    border.width: 2
    border.color: 'red'
    clip: true
    property int numBot: 1
    property var xc1: xCapa1
    property bool autoKill: true
    property var uForAutoKill

    //Scores
    property int winScore: 1000000
    property int winLastScore: 1000001


    XScores{id: xScores}
    MouseArea{
        id: maCursor
        anchors.fill: r
        hoverEnabled: true
        cursorShape: Qt.BlankCursor
        onClicked: {
            if(!r.autoKill){
                p1.s2(mouseX, mouseY)
            }else{
                p1.s2(c1.x, c1.y)
            }
        }
        onMouseXChanged:{
            if(!r.autoKill){
                c1.x=mouseX-c1.width*0.5
                c1.y=mouseY
                p1.x=mouseX-p1.width*0.5
            }
        }
    }
    Item{
        id: xCapa1
        anchors.fill: r
    }
    C1{
        id: c1
        onXChanged: {
            p1.rot(x, y)
        }
        onYChanged: {
            p1.rot(x, y)
        }
    }
    P1{
        id: p1
        y:r.height*0.5-height
        x: r.width*0.5-width
        //anchors.bottom: parent.bottom
        Component.onCompleted: {
            app.p1=p1
        }
    }
    Audio{
        id: ap
        source:'file:./sounds/p1s1.wav'
        autoLoad: true
        autoPlay: true
        onPlaybackStateChanged:{
            if(y<0-r.height&&ap.playbackState!==Audio.PlayingState){
                r.destroy(1)
            }
        }
    }


    Timer{
        id: tBotAttack
        running: true
        repeat: true
        interval: 1000
        onTriggered: {
            a('bot'+r.numBot)
            r.numBot++
        }
    }
    Timer{
        id: tCielo
        running: true
        repeat: true
        interval: 3000
        onTriggered: {
            let comp=Qt.createComponent("F1.qml")
            let obj=comp.createObject(xCapa1, {})
        }
    }
    Timer{
        id: tCielo2
        running: true
        repeat: true
        interval: 16000
        onTriggered: {
            let comp=Qt.createComponent("F2.qml")
            let obj=comp.createObject(xCapa1, {p: JS.getRandomRange(1,8)})
        }
    }
    Timer{
        id: tAutoS2
        running: mv>0
        repeat: true
        interval: 300
        property real xd
        property real yd
        property var objForKill
        property int cv: 1
        property int mv: 0
        onCvChanged: {
            //tAuto.stop()
            //tAuto.interval=(xCapa1.children.length)*10
            //tAuto.restart()
        }
        onTriggered: {
            tAuto.restart()
            if(cv===0){
                p1.rot(xd, yd)
            }
            p1.s2(xd, yd, objForKill)
            //c1.x=xd
            //c1.y=yd
            if(cv<mv){
                cv++
            }else{
                cv=0
                mv=0
            }
        }
    }
    Timer{
        id: tAuto
        running: r.autoKill
        repeat: true
        interval: 300
        onTriggered: {
            let cant=0
            let objC
            let mi=[]
            let md=[]
            var i
            /*for(i=0;i<xCapa1.children.length;i++){
                var obj=xCapa1.children[i]
                if(obj instanceof U1&&obj.x+obj.width*0.5>r.width*0.5){
                    mi.push(obj)
                }else{
                    md.push(obj)
                }
            }
            var fa
            if(mi.length>md.length){
                fa=mi
            }else{
                fa=md
            }
            //uLogView.showLog('mi: '+mi.length+' md: '+md.length)
            //return
            if(fa.length<1)return
            var obj2=fa[0]
            if(!obj2.t)return
            tAutoS2.stop()
            tAutoS2.interval=obj2.t*50
            if(obj2.x<r.width*0.5){
                tAutoS2.xd=obj2.x-app.fs*6
            }else{
                 tAutoS2.xd=obj2.x+app.fs*6
            }
           //tAutoS2.xd=obj2.x
            tAutoS2.yd=obj2.y
            tAutoS2.mv=obj2.t
            tAutoS2.restart()*/
            for(i=0;i<xCapa1.children.length;i++){
                var obj=xCapa1.children[i]
                //if((obj instanceof U1||obj instanceof MU1)&&obj.y<obj.parent.height-obj.height){
                if(obj instanceof U1&&obj.y<obj.parent.height-obj.height){

                tAutoS2.objForKill=xCapa1.children[i]
                    tAutoS2.stop()
                    tAutoS2.interval=obj.t*50
                    tAutoS2.xd=obj.x
                    tAutoS2.yd=obj.y
                    let nt=5
                   if(obj instanceof U1){
                        nt=obj.t
                   }
                   tAutoS2.mv=nt
                    tAutoS2.restart()
                    break
                }
            }
            //uLogView.showLog('Cant: '+cant)
        }
    }
    function a(objName){
        let wa=parseInt(app.fs*1.5)
        let comp=Qt.createComponent("U1.qml")
        let randomPosX
        let posIzqOrDer=JS.getRandomRange(1,3)
        //uLogView.showLog('pos: '+posIzqOrDer)
        if(posIzqOrDer===1){
            randomPosX=JS.getRandomRange(0, r.width*0.5)
        }else{
            randomPosX=JS.getRandomRange(r.width*0.5, r.width)
        }
        let e=JS.getRandomRange(1,6)
        let obj=comp.createObject(xCapa1, {w: wa, x:randomPosX, y:0-wa, nickName: objName, t:e})
        /*if(r.autoKill){
            p1.s2(obj.x, obj.y)
        }*/
    }
}

