const rl = @import("raylib");
const math = @import("std").math;
const PI = math.pi;

const SCREEN_FACTOR = 80;
const SCREEN_WIDTH = 16 * SCREEN_FACTOR;
const SCREEN_HEIGHT = 9 * SCREEN_FACTOR;
const BRANCH_COUNT = 7.0;
const BRANCH_ANGLE = 2.0 * PI / BRANCH_COUNT;
const BRANCH_LEN = SCREEN_FACTOR * 2;
const BRANCH_THICK = 10.0;

pub fn draw_snowflake(center: rl.Vector2, length: f32, thick: f32, level: i32) void {
    if (level <= 0) {
        return;
    }
    for (0..BRANCH_COUNT) |i| {
        const angle: f32 = BRANCH_ANGLE * @as(f32, @floatFromInt(i));
        const branch: rl.Vector2 = .{ .x = center.x + math.cos(angle) * length, .y = center.y + math.sin(angle) * length };
        rl.drawLineEx(center, branch, thick, rl.colorFromHSV(@as(f32, @floatFromInt(i)) * 30, 0.5, 0.69));
        draw_snowflake(branch, length * 0.5, thick * 0.5, level - 1);
    }
}
pub fn main() anyerror!void {
    rl.initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Snowflake");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    const midp: rl.Vector2 = .{ .x = SCREEN_WIDTH * 0.5, .y = SCREEN_HEIGHT * 0.5 };

    // Main game loop
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(rl.Color.black);
        draw_snowflake(midp, BRANCH_LEN, BRANCH_THICK, 4);
    }
}
