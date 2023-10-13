/* --------------- Orbitron Space Station --------------- */
// Subtask 4: class StationModule
class StationModule {
    // No need for being private
    let moduleName: String
    var drone: Drone?
    
    init(moduleName: String, drone: Drone?) {
        self.moduleName = moduleName
        self.drone = drone
    }
    
    func assignTaskToDrone(task: String) {
        drone?.task = task
    }
}


// Subtask 1: class ControlCenter
class ControlCenter: StationModule {
    // Both can be private:
    private var isLockedDown: Bool
    private let securityCode: String
    
    init(isLockedDown: Bool, securityCode: String, moduleName: String, drone: Drone?) {
        self.isLockedDown = isLockedDown
        self.securityCode = securityCode
        super.init(moduleName: moduleName, drone: drone)
    }
    
    func lockdown(password: String) {
        if isLockedDown {
            print("Control Center is Already Locked Down!")
        } else if password == securityCode {
            isLockedDown = true
            print("Control Center Successfully Locked Down...")
        } else {
            print("Password Error! Lockdown Failed...")
        }
    }
    
    func isUnderLockdown() {
        if isLockedDown {
            print("Control Center is Locked Down!")
        } else {
            print("Control Center is NOT Locked Down!")
        }
    }
}


// Subtask 2: class ResearchLab
class ResearchLab: StationModule {
    // Nothing needs to be private here:
    var specimens: [String]
    
    init(specimens: [String], moduleName: String, drone: Drone?) {
        self.specimens = specimens
        super.init(moduleName: moduleName, drone: drone)
    }
    
    func addSpecimen(_ newSpecimen: String) {
        specimens.append(newSpecimen)
    }
}


// Subtask 3: class LifeSupportSystem
class LifeSupportSystem: StationModule {
    // Can be private because we still access it from support method
    private let oxygenLevel: Int
    
    init(oxygenLevel: Int, moduleName: String, drone: Drone?) {
        self.oxygenLevel = oxygenLevel
        super.init(moduleName: moduleName, drone: drone)
    }
    
    func currentOxygenLevel() {
        print("Current Oxygen Level: \(oxygenLevel)")
    }
}


// Subtask 6: class Drone
class Drone {
    var task: String?
    unowned var assignedModule: StationModule
    weak var missionControlLink: MissionControl?
    
    init(task: String?, assignedModule: StationModule, missionControlLink: MissionControl?) {
        self.task = task
        self.assignedModule = assignedModule
        self.missionControlLink = missionControlLink
    }
    
    func hasTask() {
        if task != nil {
            print("This drone has task: \(task ?? "")")
        } else {
            print("This drone has no task assigned!")
        }
    }
}


// Subtask 7: class OrbitronSpaceStation
class OrbitronSpaceStation {
    let controlCenter: ControlCenter
    let controlDrone: Drone
    let researchLab: ResearchLab
    let researchDrone: Drone
    let lifeSupport: LifeSupportSystem
    let lifeSupportDrone: Drone
    
    init() {
        controlCenter = ControlCenter(
            isLockedDown: false,
            securityCode: "CONTROL123",
            moduleName: "Big Brother is Watching You!",
            drone: nil)
        controlDrone = Drone(
            task: nil,
            assignedModule: controlCenter,
            missionControlLink: nil)
        controlCenter.drone = controlDrone
        
        researchLab = ResearchLab(
            specimens: [],
            moduleName: "Area 51",
            drone: nil)
        researchDrone = Drone(
            task: nil,
            assignedModule: researchLab,
            missionControlLink: nil)
        researchLab.drone = researchDrone
        
        lifeSupport = LifeSupportSystem(
            oxygenLevel: 100,
            moduleName: "Stayin' Alive",
            drone: nil)
        lifeSupportDrone = Drone(
            task: nil,
            assignedModule: lifeSupport,
            missionControlLink: nil)
        lifeSupport.drone = lifeSupportDrone
    }
    
    func lockdown(password: String) {
        controlCenter.lockdown(password: password)
    }
}



// Subtask 8: class MissionControl
class MissionControl {
    var spaceStation: OrbitronSpaceStation?
    
    func connectToSpaceStation(_ spaceStation: OrbitronSpaceStation?) {
        self.spaceStation = spaceStation
        print("Connection Established!")
    }
    
    func requestControlCenterStatus() {
        spaceStation?.controlCenter.isUnderLockdown()
    }
    
    func requestOxygenStatus() {
        spaceStation?.lifeSupport.currentOxygenLevel()
    }
    
    func requestDroneStatus(drone: Drone) {
        drone.hasTask()
    }
}


// Subtask 9 _ Simulation:
let orbitron = OrbitronSpaceStation()
let missionControl = MissionControl()
missionControl.connectToSpaceStation(orbitron)
missionControl.requestControlCenterStatus()
orbitron.controlCenter.assignTaskToDrone(task: "Control Planet Environment!")
orbitron.researchLab.assignTaskToDrone(task: "Research Specimens!")
orbitron.lifeSupport.assignTaskToDrone(task: "Control & Support Life!")
missionControl.requestDroneStatus(drone: orbitron.controlDrone)
missionControl.requestDroneStatus(drone: orbitron.researchDrone)
missionControl.requestDroneStatus(drone: orbitron.lifeSupportDrone)
missionControl.requestOxygenStatus()
orbitron.lockdown(password: "INCORRECT")
orbitron.lockdown(password: "CONTROL123")
// Checking if we get notified that control center is already locked down:
orbitron.lockdown(password: "CONTROL123")
