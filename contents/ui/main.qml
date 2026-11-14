import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    // Replace with your Linux shell command
    readonly property string shellCommand: "rofi -show drun"

    // Allows the widget to expand and match native panel icon sizes
    Plasmoid.constraintHints: Plasmoid.CanFillArea

    // Default size for plasmoidviewer or desktop placement
    width: Kirigami.Units.iconSizes.huge
    height: Kirigami.Units.iconSizes.huge

    // Matches the panel's height (horizontal panel) or width (vertical panel)
    Layout.minimumWidth: Kirigami.Units.iconSizes.small
    Layout.minimumHeight: Kirigami.Units.iconSizes.small
    Layout.preferredWidth: root.height
    Layout.preferredHeight: root.width

    Plasma5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []

        onNewData: (sourceName, data) => {
            disconnectSource(sourceName)
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            executable.connectSource(root.shellCommand)
        }

        Kirigami.Icon {
            anchors.fill: parent
            // Loads your custom SVG or PNG from contents/images/
            source: Qt.resolvedUrl("../images/minrofoid.svg")
            active: mouseArea.containsMouse
        }
    }
}
