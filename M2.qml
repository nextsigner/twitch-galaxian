import QtQuick 2.0

Item {
    id: r
    width: w
    height: width
    property int w: app.fs
    property int vel: 500
    property int xd:-1
    property int yd:-1
    onYChanged:{
        td.restart()
        if(y<0-r.height){
            r.destroy(1)
        }
    }
    Behavior on x{
        NumberAnimation{duration: r.vel;}
    }
    Behavior on y{
        NumberAnimation{duration: r.vel;}
    }
    Rectangle{
        id: bg
        anchors.fill: r
        radius: width*0.5
    }
    Timer{
        id: td
        interval: 250
        onTriggered: {
            r.destroy(1)
        }
    }
    Timer{
        id: tdir
        running: true
        repeat: true
        interval: 50
        onTriggered: {
            r.x=maCursor.mouseX
            r.y=maCursor.mouseY
        }
    }
    Component.onCompleted: {
        r.x=r.xd
        r.y=r.yd
    }
}
