import { Test, TestingModule } from '@nestjs/testing';
import { UserController } from './user.controller';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UserRole } from '../schemas/user.schema';

const mockUser = {
  _id: '1',
  fullName: 'Test User',
  email: 'test@example.com',
  password: 'password',
  role: 'user',
};

const mockUserService = {
  createUser: jest.fn().mockResolvedValue(mockUser),
  getUsers: jest.fn().mockResolvedValue([mockUser]),
  getUserById: jest.fn().mockResolvedValue(mockUser),
  deleteUser: jest.fn().mockResolvedValue(mockUser),
};

describe('UserController', () => {
  let controller: UserController;
  let service: UserService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UserController],
      providers: [
        {
          provide: UserService,
          useValue: mockUserService,
        },
      ],
    }).compile();

    controller = module.get<UserController>(UserController);
    service = module.get<UserService>(UserService);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should create a user', async () => {
    const createUserDto: CreateUserDto = {
      fullName: 'Test User',
      email: 'test@example.com',
      password: 'password',
      role: UserRole.USER,
    };
    const result = await controller.createUser(createUserDto);
    expect(result).toEqual(mockUser);
  });

  it('should return all users', async () => {
    const result = await controller.getUsers();
    expect(result).toEqual([mockUser]);
  });

  it('should return a user by id', async () => {
    const result = await controller.getUserById('1');
    expect(result).toEqual(mockUser);
  });

  it('should delete a user', async () => {
    const result = await controller.deleteUser('1');
    expect(result).toEqual(mockUser);
  });
});