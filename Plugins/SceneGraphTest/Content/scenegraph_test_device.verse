
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/SceneGraph }


using {RubberDuck}

# A Verse-authored creative device that can be placed in a level
scenegraph_test_device := class(creative_device):

    @editable
    StartButton : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        StartButton.InteractedWithEvent.Subscribe(OnStartButtonInteractedWith)
        return

    OnEnd<override>() : void=
        if:
            RootEntity := GetSimulationEntity[]
        then:
            Entities := RootEntity.GetEntities()
            for(Entity : Entities):
                Entity.Dispose()
            
        return

    OnStartButtonInteractedWith(Agent : agent) : void =
        if:
            RootEntity := GetSimulationEntity[]
        then:
            for(Index := 1..50):
                DuckInstance : Prefab_RubberDuck = Prefab_RubberDuck{}
                RootEntity.AddEntities(array{DuckInstance})

                if:
                    TransformComponent := DuckInstance.GetComponents(transform_component)[0]
                    RubberDuckComponent := DuckInstance.GetComponents(rubberduck_component)[0]
                then:
                    var InitialTransform : transform = TransformComponent.GetTransform()
                    set InitialTransform.Translation = vector3{X:=Index * 200.0, Y:=-700.0, Z:=150.0}
                    RubberDuckComponent.SetInitialTransform(InitialTransform)
                    RubberDuckComponent.SetTimeOffset(Index * 0.2)

        return

    PrintComponents(Entity : entity) : void=
        Components := Entity.GetComponents(component)
        for(Component : Components):
            if:
                CastedComponent := transform_component[Component]
            then:
                Position := CastedComponent.GetTransform().Translation
                Print("Transform Component, {Position.X}, {Position.Y}, {Position.Z}")

            if:
                CastedComponent := collision_component[Component]
            then:
                Print("Collision Component")

            if:
                CastedComponent := tag_component[Component]
            then:
                Print("Tag Component")

            if:
                CastedComponent := directional_light_component[Component]
            then:
                Print("Directional Light Component")

            if:
                CastedComponent := light_component[Component]
            then:
                Print("Light Component")

            if:
                CastedComponent := mesh_component[Component]
            then:
                Print("Mesh Component")

            if:
                CastedComponent := parent_constraint_component[Component]
            then:
                Print("Parent Constraint Component")

            if:
                CastedComponent := text_display_component[Component]
            then:
                Print("Text Display Component")

            if:
                CastedComponent := spot_light_component[Component]
            then:
                Print("Spot Light Component")

        return