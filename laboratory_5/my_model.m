clear L
deg = pi/180;

L(1) = Link('d', 0, 'a', 0, 'alpha', 0, ...
    'I', [0, 0, 0], ...
    'r', [0, 0, 0], ...
    'm', 0, ...
    'Jm', 10e-4, ...
    'G', 500, ...
    'B', 10*10e-4, ...
    'Tc', [0 0], ...
    'qlim', [-180 180]*deg,...
    'revolute', ...
    'modified');

L(2) = Link('d', 0, 'a', 1, 'alpha', -pi/2, ...
    'I', [0.0125, 0.84, 0.84], ...
    'r', [0.5, 0, 0], ...
    'm', 10, ...
    'Jm', 10e-4, ...
    'G', 500, ...
    'B', 10*10e-4, ...
    'Tc', [0 0], ...
    'qlim', [-90 90]*deg, ...
    'revolute', ...
    'modified');

L(3) = Link('d', 0, 'a', 1, 'alpha', 0,  ...
    'I', [0.0125, 0.84, 0.84], ...
    'r', [0.5, 0, 0], ...
    'm', 10, ...
    'Jm', 10e-4, ...
    'G', 500, ...
    'B', 10*10e-4, ...
    'Tc', [0, 0], ...
    'qlim', [-90 90]*deg, ...
    'revolute', ...
    'modified');

robot = SerialLink(L, 'name', 'My robot', 'gravity', [0 0 -9.8]);

robot.gravity = [0 0 -9.8];

qz = [0 0 0]; % zero angles, L shaped pose
qr = [0 pi/2 -pi/2]; % ready pose, arm up
qs = [0 0 -pi/2 ];
qn = [0 pi/4 pi];
home = [0 pi/2 0]; %position home
hold = [0 0 0]; %position hold
view(3);

load_home = [1 0 0];
load_hold = [0 1 0];

robot.plot(home);
%hold on
%robot.plot(load_hold);
%robot.teach;

M = robot.inertia(hold);
C = robot.coriolis(hold, home);
G_home = robot.gravload(load_home);
G_hold = robot.gravload(load_hold);
F = robot.friction(qz);
J_home = robot.jacob0(home);
J_hold = robot.jacob0(hold);

T_home = J_home.*G_home  %torque with load with joint2 = 90, others 0
T_hold = J_hold.*G_hold  %torque with load with joints 0

clear L