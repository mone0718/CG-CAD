void setup() {
    size(500, 500);
}

void draw() {
    background(40);
    int n = 6;
    for (int i=0; i<n+1; i++) {
        int x = position_x(n, i);
        int y = position_y(n, i);
        println();
        fill(0, 255, 255);
        noStroke();
        ellipse(x, y, 10, 10);
    }
}

int position_x(int n, int i) {
    int x = 0;

    x = width / 2 + int(150 * cos(radians(180/n * i)));

    return x;
}

int position_y(int n, int i) {
    int y = 0;

    y = height / 2 + 50 - int(150 * sin(radians(180/n * i)));

    return y;
}
