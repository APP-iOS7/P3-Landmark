//
//  AuthView.swift
//  FirebaseAuth
//
//  Created by 김덕원 on 2/5/25.
//

import SwiftUI

struct AuthView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var VM = AuthViewModel()
    
    var body: some View {
        NavigationStack(path: $VM.navigationPath) {
            ZStack {
                // Background
                ZStack {
                    Color.black
                        .opacity(0.65)
                        .zIndex(1)
                    
                    // Background Image
                    GeometryReader { geometry in
                        Image("TripImage")
                            .resizable()
                            .frame(width: geometry.size.width,height: geometry.size.height )
                            .clipped()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    // App Name
                    VStack(spacing: 5) {
                        Image(systemName: "airplane.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.white)
                            .padding(.top, 50)
                        
                        Text("TripList")
                            .font(.system(size: 36, weight: .bold,
                                          design: .rounded))
                            .foregroundStyle(.white)
                        
                        Text(VM.isSignUp ? "Create Your Account" :
                                "Welcome Back")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(Color.white
                            .opacity(0.85))
                    }
                    
                    HStack(spacing: 10) {
                        
                        // Sign In
                        AuthButton(title: "Sign In", isSelected: VM.selectedAuthStyle == .signIn) {
                            withAnimation(.easeInOut) {
                                VM.selectedAuthStyle = .signIn
                            }
                        }
                        
                        // Sign Up
                        AuthButton(title: "Sign Up", isSelected: VM.selectedAuthStyle == .signUp) {
                            withAnimation(.easeInOut) {
                                VM.selectedAuthStyle = .signUp
                            }
                        }
                        
                    }
                    .padding(1)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    
                    VStack(spacing: 15) {
                        // Email
                        TextField("Email", text:$VM.email,
                                  prompt: Text("Email").foregroundStyle(.white)
                        )
                        .textFieldStyle(IconTextFieldStyle(iconName:"envelope.fill"))
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        
                        // Password
                        SecureField("Password", text: $VM.password,
                                    prompt: Text("Password").foregroundStyle(.white))
                        .textFieldStyle(IconTextFieldStyle(iconName:"lock.fill"))
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    
                    Button {
                        VM.buttonDidTap()
                        withAnimation {
                            VM.isLoading = true
                        }
                    } label: {
                        HStack {
                            if !VM.isLoading {
                                Text(VM.isSignUp ? "Sign Up" : "Login")
                                    .font(.system(.title3, design: .rounded, weight: .bold))
                            } else {
                                // Loading indicator
                                ProgressView()
                                    .tint(.white)
                            }
                        }
                        .frame(width: 350)
                        .padding(.vertical, 14)
                        .background(VM.isLoading ? .gray : .blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 30)
                    
                    // 네비게이션 이동
                    .navigationDestination(for: String.self) { view in
                        if view == "Main" {
                            MypageView()
                        }
                    }
                    
                    //Forgot Password
                    Button {
                        VM.showForgetPass.toggle()
                    } label: {
                        Text("Forgot Password?")
                            .font(.system(.headline, design: .rounded, weight: .medium))
                            .foregroundStyle(.white.opacity(0.85))
                    }
                    
                    Button {
                        withAnimation {
                            VM.selectedAuthStyle = VM.isSignUp ? . signIn : . signUp
                        }
                    } label: {
                        Text(
                            VM.isSignUp ? "Aready habe an account? **Login**" : "Don't have an account? **Sign up**"
                        )
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.white.opacity(0.85))
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                }
                .padding()
                .sheet(isPresented: $VM.showForgetPass) {
                    PasswordResetView(showForgetPass: $VM.showForgetPass)
                        .padding()
                        .presentationDetents([.fraction(0.25)])
                        .presentationDragIndicator(.visible)
                        .presentationBackground(.ultraThinMaterial)
                }
            }
        }
    }
}

#Preview {
    AuthView()
}
