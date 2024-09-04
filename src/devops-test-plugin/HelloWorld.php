<?php

class HelloWorld
{
    private string $name;

    public function __construct(string $name)
    {
        $this->name = $name;
    }

    public function print(): void
    {
        echo "Hello " . $this->name;
    }
}