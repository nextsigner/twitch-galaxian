import QtQuick 2.0
import QtMultimedia 5.0
import "funcs.js" as JS

Item {
    id: r
    width: w
    height: w
    property int w: app.fs*3
    property string nickName: 'bot'
    property int t: 1
    property int r: 0
    property int numShot: 1
    property color c1: 'red'
    onYChanged:{
        if(r.y>r.parent.height&&apu.playbackState!==Audio.PlayingState){
            r.destroy(10)
        }
    }
    Behavior on x{
        NumberAnimation{duration: 50; easing.type: Easing.InOutQuad}
    }
    Behavior on y{
        NumberAnimation{id: nay; duration: 14000-(1000*r.t); easing.type: Easing.InOutQuad}
    }
    Rectangle{
        id: life
        width: r.width
        height: 4
        color: '#ff8833'
        anchors.bottom: r.top
        anchors.bottomMargin: app.fs*0.5
    }
    Rectangle{
        id: xObj
        width: r.w
        height: width
        color: 'transparent'
        Image {
            id: img1
            source: "file:./img/img_e"+r.t+".png"
            width: r.w
            height: r.w
            rotation: 180
        }

        UText{
            id: label
            text: r.nickName
            font.pixelSize: app.fs*0.5
            anchors.bottom: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: app.c2
        }
        //border.width: 1
        //border.color: 'red'
        ParallelAnimation{
            id: an1
            NumberAnimation{
                target: xObj
                property: 'rotation'
                to:270
                duration: 1000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation{
                target: xObj
                property: 'x'
                to:r.width
                duration: 300
            }
            NumberAnimation{
                target: xObj
                property: 'y'
                to:r.width
                duration: 300
            }
        }
        ParallelAnimation{
            id: an2
            NumberAnimation{
                target: xObj
                property: 'rotation'
                to:359
                duration: 1500
                easing.type: Easing.InOutQuad
            }
            NumberAnimation{
                target: xObj
                property: 'x'
                to:0-r.width*0.3
                duration: 500
            }
            NumberAnimation{
                target: xObj
                property: 'y'
                to:0-r.width*3
                duration: 500
            }
        }
        ParallelAnimation{
            id: an3
            NumberAnimation{
                target: xObj
                property: 'rotation'
                to:70
                duration: 800
                easing.type: Easing.InOutQuad
            }
            NumberAnimation{
                target: xObj
                property: 'x'
                to:r.width*0.2
                duration: 800
            }
            NumberAnimation{
                target: xObj
                property: 'y'
                to:0-r.width*1.5
                duration: 1000
            }
        }

    }
    Audio{
        id: arec
        source:'file:./sounds/r1.mp3'
        autoLoad: true
        autoPlay: false
    }
    Audio{
        id: apu
        source:'file:./sounds/e1.mp3'
        autoLoad: true
        autoPlay: false
        property bool ue: false
        onStopped:{
            if(ue&&apu.playbackState===Audio.StoppedState){
                r.destroy(1)
            }
        }
    }
    Timer{
        running: true
        repeat: false
        interval: 500
        onTriggered: {
            let ws=app.fs*0.5
            let comp=Qt.createComponent("MU1.qml")
            let obj=comp.createObject(r.parent, {w: ws, x: r.x+r.width*0.5-ws*0.5, y:r.y, xd: p1.x, yd: p1.y+p1.height+100, objectName: 'uobj'+r.numShot})
            r.numShot++
        }
    }
    Timer{
        running: true
        repeat: true
        interval: 50
        onTriggered: {
            stop()
            for(let i=0;i<x1.children.length;i++){
                let obj=x1.children[i]
                if(obj.objectName.indexOf('obj')===0){
                    if(obj.y+r.height>=r.y&&obj.y-r.height<r.y&&obj.x+r.width>=r.x&&obj.x-r.width<r.x){
                        obj.x=10000
                        stop()
                        r.r++
                        if(r.r<r.t){
                            life.width=r.width-r.width/(r.t)*(r.r)
                            recept()
                        }else{
                            r.e()
                        }
                    }
                }
            }
            start()
        }
    }
    Component.onCompleted: {
        r.y=r.parent.height+r.height+100
    }
    function r(){
        x+=10
    }
    function l(){
        x-=10
    }
    function s(){
        let ws=app.fs
        let comp=Qt.createComponent("M1.qml")
        let obj=comp.createObject(r.parent, {w: ws, x: r.x+r.width*0.5-ws*0.5, y:r.y})
    }
    function recept(){
        arec.play()
    }
    function e(){
        //unik.speak('Destruido')
        life.visible=false
        let ran=JS.getRandomRange(1, 4)
        if(ran===1){
            an1.start()
        }else if(ran===2){
            an2.start()
        }else if(ran===3){
            an3.start()
        }else{
            an1.start()
        }
        nay.duration=500
        r.y=r.y-r.height*2
        apu.ue=true
        apu.play()
    }
}
