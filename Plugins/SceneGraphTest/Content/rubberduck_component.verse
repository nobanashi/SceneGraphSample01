using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SceneGraph }
using { /UnrealEngine.com/Temporary/SpatialMath }

# A Verse-authored component that can be added to entities
rubberduck_component<public> := class(component):

    var _StartTime : float = 0.0
    var _TimeOffset : float = 0.0
    var _InitialTransform : transform = transform{}
    _AnimDuration : float = 2.0
    _AnimHeight : float = 150.0
    var _Index : int = 0
    var _LastUpdatedTime : float = 0.0
    var _No : int = 0

    OnSimulate<override>()<suspends>:void =
        (super:)OnSimulate()
        set _StartTime = GetSimulationElapsedTime()

        TickEvents.PrePhysics.Subscribe(TickPrePhysics)
        TickEvents.PostPhysics.Subscribe(TickPostPhysics)
        return

    SetInitialTransform<public>(Transform : transform) : void=
        set _InitialTransform = Transform
        return

    SetTimeOffset<public>(TimeOffset : float) : void=
        set _TimeOffset = TimeOffset
        return

    TickPrePhysics(DeltaTime : float) : void=
        if:
            TransformComponent := Entity.GetComponents(transform_component)[0]
        then:
            CurrentTime := GetSimulationElapsedTime()
            
            Radians := DegreesToRadians(360.0) * (CurrentTime - _TimeOffset) / _AnimDuration
            OffsetZ:= Sin(Radians) * _AnimHeight 
            var CurrentTransform : transform = _InitialTransform
            set CurrentTransform.Translation.Z = CurrentTransform.Translation.Z + OffsetZ
            TransformComponent.SetTransform(CurrentTransform)

            set _LastUpdatedTime = CurrentTime

        return

    TickPostPhysics(DeltaTime : float) : void=
        return

    OnInitialized<override>():void =
        (super:)OnInitialized()
        return

    OnUninitializing<override>():void = 
        (super:)OnUninitializing()
        return

    OnAddedToScene<override>():void =
        (super:)OnAddedToScene()
        Print("OnAddedToScene")
        return

    OnRemovingFromScene<override>():void =
        (super:)OnRemovingFromScene()
        Print("OnRemovingFromScene")
        return

    # Sets up collision simulation for the entity.
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()
        Print("OnBeginSimulation")
        return

    OnEndSimulation<override>():void = 
        (super:)OnEndSimulation()
        Print("OnEndSimulation")
        return
