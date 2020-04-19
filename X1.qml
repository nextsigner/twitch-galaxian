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
    property int numBot: 1
    property var xc1: xCapa1
    property bool autoKill: true
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
        source:'file:./sounds/m1.mp3'
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
        interval: 2000
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
        property int cv: 1
        property int mv: 0
        onCvChanged: {
            //tAuto.stop()
            //tAuto.interval=(xCapa1.children.length)*10
            //tAuto.restart()
        }
        onTriggered: {
            tAuto.restart()
            p1.s2(xd, yd)
            c1.x=xd
            c1.y=yd
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
            for(let i=0;i<xCapa1.children.length;i++){
                let obj=xCapa1.children[i]
                if(obj instanceof U1&&obj.y<obj.parent.height-obj.height){
                    tAutoS2.stop()
                    tAutoS2.interval=obj.t*50
                    tAutoS2.xd=obj.x
                    tAutoS2.yd=obj.y
                    tAutoS2.mv=obj.t
                    tAutoS2.restart()
                    break
                }
            }
            //uLogView.showLog('Cant: '+cant)
        }
    }
    function a(objName){
        let wa=app.fs*1.5
        let comp=Qt.createComponent("U1.qml")
        let randomPosX=JS.getRandomRange(0+wa, r.width-wa)
        let e=JS.getRandomRange(1,5)
        let obj=comp.createObject(xCapa1, {w: wa, x:randomPosX, y:0, nickName: objName, t:e})
        /*if(r.autoKill){
            p1.s2(obj.x, obj.y)
        }*/
    }
}

