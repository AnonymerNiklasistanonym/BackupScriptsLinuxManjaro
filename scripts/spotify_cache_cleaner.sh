#!/usr/bin/env bash

echo "> BEFORE CLEANING"
du -h -d 0 $HOME/.cache/spotify

echo "> CLEANING SPOTIFY CACHE..."
rm -rf $HOME/.cache/spotify/Browser/Cache/*
rm -rf $HOME/.cache/spotify/Data/*
rm -rf $HOME/.cache/spotify/Storage/*

echo "> AFTER CLEANING"
du -h -d 0 $HOME/.cache/spotify
