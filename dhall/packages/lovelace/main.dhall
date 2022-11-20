let ResourceType: Type = < module >
let ResourcesType = List { url: Text, type: ResourceType }
let DefaultResource = { type = ResourceType.module }

let makeAreaFilter = \(ot: Optional Text) -> merge {
    None = "",
    Some = \(t: Text) -> " == '${t}'"
} ot

let makeSensorLoad: Text -> Optional Text -> { name: Text, state: Text} =
\(name: Text) -> \(entityId: Optional Text) -> {
    name,
    state = List/fold Text [
        "{% set power = namespace(value=0) %}",
        "{% set sensors = namespace(value = {}) %}",
        "{% for entity in states.sensor",
        "       if entity.entity_id.endswith('_power')",
        "       and states(entity.entity_id) not in ['unavailable', 'unknown', 'None']",
        "       and area_name(entity.entity_id)" ++ makeAreaFilter entityId,
        "%}",
        "{%       set power.value = power.value |int + entity.state |int %}",
        "{% endfor %}",
        "{{ (power.value) | round(2) }}"
    ] Text (\(item: Text) -> \(acc: Text) -> item ++ "\n" ++ acc) ""
}

in {
    view = {
        lovelace = {
            mode = "yaml",
            resources = [
                {
                    url = "/hacsfiles/lovelace-auto-entities/auto-entities.js",
                } // DefaultResource,
                {
                    url = "/hacsfiles/ha-sankey-chart/ha-sankey-chart.js",
                } // DefaultResource
            ] : ResourcesType
        },
        homeassistant = {
            customize = {
                `sensor.total_load` = {
                    friendly_name = "Total Load"
                },
                `sensor.bedroom_load` = {
                    friendly_name = "Bedroom Load"
                },
                `sensor.kitchen_load` = {
                    friendly_name = "Kitchen Load"
                },
                `sensor.hallway_load` = {
                    friendly_name = "Hallway Load"
                },
                `sensor.bathroom_load` = {
                    friendly_name = "Bathroom Load"
                },
                `sensor.garage_load` = {
                    friendly_name = "Garage Load"
                }
            }
        },
        template.sensor = [
            makeSensorLoad "total_load" (None Text),
            makeSensorLoad "bedroom_load" (Some "Bedroom"),
            makeSensorLoad "kitchen_load" (Some "Kitchen"),
            makeSensorLoad "hallway_load" (Some "Hallway"),
            makeSensorLoad "bathroom_load" (Some "Bathroom"),
            makeSensorLoad "garage_load" (Some "Garage"),
        ]
    }
}
