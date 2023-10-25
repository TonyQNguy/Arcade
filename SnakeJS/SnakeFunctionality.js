const canvas = document.getElementById('snakeGame');
const canvasContent = canvas.getContext('2d');

class snakeLink { 
    constructor(x, y) { 
        this.x = x;
        this.y = y; 
    }
}

// grid variables
let numTiles = 20;
let tileSize = canvas.clientWidth / numTiles - 2;
// head of snake variables
let headX = 10;
let headY = 10;
// speed of snake variables
let speed = 7;
let speedX = 0;
let speedY = 0;
// apple variables
let appleX = 5;
let appleY = 5;
// default score
let score = 0;
// array for snake links
const snakeLinks = [];
let tailLength = 2;

function drawGame() { 
    moveSnake();

    let check = isGameOver();
    if (check) { 
        return;
    }
    resetGame();
    drawSnake();
    drawApple();

    checkIfHit();
    drawScoreboard();
    setTimeout(drawGame, 1000 / speed);
}

function drawSnake() { 
    canvasContent.fillStyle = "green";

    for (let i = 0; i < snakeLinks.length; i++) { 
        let links = snakeLinks[i];
        canvasContent.fillRect(links.x * numTiles, links.y * numTiles, tileSize, tileSize);
    }
    snakeLinks.push(new snakeLink(headX, headY));
    if (snakeLinks.length > tailLength) { 
        snakeLinks.shift();
    }
    canvasContent.fillStyle = "orange";
    canvasContent.fillRect(headX * numTiles, headY * numTiles, tileSize, tileSize);
}

function drawApple() { 
    canvasContent.fillStyle = "red";
    canvasContent.fillRect(appleX * numTiles, appleY * numTiles, tileSize, tileSize);
}

function drawScoreboard() { 
    canvasContent.fillStyle = "white";
    canvasContent.font = "10px verdana";
    canvasContent.fillText("Score: " + score, canvas.clientWidth - 50, 10);
}

function isGameOver() { 
    let gameover = false;

    if (speedX === 0 && speedY === 0) { 
        return false;
    }

    if (headX < 0) { 
        gameover = true;
    } 
    else if (headX === numTiles) { 
        gameover = true;
    } 
    else if (headY < 0) { 
        gameover = true; 
    } 
    else if (headY === numTiles) { 
        gameover = true; 
    }

    for (let i = 0; i < snakeLinks.length; i++) { 
        let link = snakeLinks[i];
        if (link.x === headX && link.y === headY) { 
            gameover = true;
            break;
        }
    }

    if (gameover) { 
        canvasContent.fillStyle = "white";
        canvasContent.font = "25px verdana";
        canvasContent.fillText("Uh Oh You Stink!", canvas.clientWidth/5, canvas.clientHeight/2);
    }

    return gameover;
}

document.body.addEventListener('keydown', keyPressed);

function keyPressed(event) { 
    // snake up
    if (event.keyCode == 38) { 
        if (speedY == 1)
            return; 
        speedX = 0;
        speedY = -1;
    }
    // snake down
    if (event.keyCode == 40) { 
        if (speedY == -1)
            return; 
        speedX = 0;
        speedY = 1;
    }
    // snake left
    if (event.keyCode == 37) { 
        if (speedX == 1)
            return; 
        speedX = -1;
        speedY = 0;
    }
    // snake right
    if (event.keyCode == 39) { 
        if (speedX == -1)
            return; 
        speedX = 1;
        speedY = 0;
    }
}

function moveSnake() { 
    headX = headX + speedX;
    headY = headY + speedY;
}

function checkIfHit() { 
    if (appleX == headX && appleY == headY) { 
        appleX = Math.floor(Math.random() * numTiles);
        appleY = Math.floor(Math.random() * numTiles);
        tailLength++;
        score++;
    }
}

function resetGame() { 
    canvasContent.fillStyle = "black";
    canvasContent.fillRect(0, 0, canvas.clientWidth, canvas.clientHeight);
}

drawGame();

