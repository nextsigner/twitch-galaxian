import QtQuick 2.0

Item {
    id: r
    width: w
    height: width
    property int w: app.fs
    property int vel: 3000
    property int xd: 0
    property int yd: 0
    onYChanged:{
        if(y>r.parent.height){
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
        color: 'red'
        radius: width*0.5
    }
    Component.onCompleted: {
        r.x=r.xd
        r.y=r.yd
    }
}
